package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

@Controller
public class ProductController {
    private final ProductService productService;
    private UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(Model model,
            @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                // convert from String to int
                page = Integer.parseInt(pageOptional.get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(page - 1, 1);
        Page<Product> products = this.productService.fetchProducts(pageable);
        List<Product> listProducts = products.getContent();
        model.addAttribute("products1", listProducts);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", products.getTotalPages());
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String postCreateProduct(Model model,
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProductBindingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {

        // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }
        String image = this.uploadService.handleSaveUploadFile(file, "product");
        product.setImage(image);
        this.productService.createProduct(product);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.getProductById(id);
        model.addAttribute("id", id);
        model.addAttribute("currentProduct", currentProduct);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.getProductById(id);
        model.addAttribute("currentProduct", currentProduct);
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("currentProduct") Product junior) {
        long idProduct = junior.getId();
        this.productService.deleteProductById(idProduct);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getMegetUpdateProductPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.getProductById(id);
        model.addAttribute("currentProduct", currentProduct);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postUpdateProduct(Model model,
            @ModelAttribute("currentProduct") @Valid Product junior,
            BindingResult newProductBindingResult,
            @RequestParam("juniorFile") MultipartFile file) {

        // validate
        if (newProductBindingResult.hasErrors()) {
            long id = junior.getId();
            return "admin/product/update";
        }

        Product currentPro = this.productService.getProductById(junior.getId());
        if (currentPro != null) {
            if (!file.isEmpty()) {
                String imagePro = this.uploadService.handleSaveUploadFile(file, "product");
                currentPro.setImage(imagePro);
            }

            currentPro.setDetailDesc(junior.getDetailDesc());
            currentPro.setShortDesc(junior.getShortDesc());

            currentPro.setFactory(junior.getFactory());
            currentPro.setName(junior.getName());
            currentPro.setPrice(junior.getPrice());
            currentPro.setTarget(junior.getTarget());
            this.productService.createProduct(currentPro);
        }
        return "redirect:/admin/product";
    }
}
