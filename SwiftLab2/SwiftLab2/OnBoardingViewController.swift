//
//  OnBoardingViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 21/04/2026.
//

import UIKit

class OnBoardingViewController: UIPageViewController , UIPageViewControllerDataSource , UIPageViewControllerDelegate  {
    
    let pageControl = UIPageControl()
    let nextButton = UIButton()
    var currentPage = 0
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Welcome to Movies App",
                        description: "Discover and track your favorite movies",
                        image: UIImage(systemName: "film")),
        OnboardingSlide(title: "Add Your Movies",
                        description: "Build your personal movie collection easily",
                        image: UIImage(systemName: "plus.circle")),
        OnboardingSlide(title: "Rate & Review",
                        description: "Rate movies and share your thoughts with others",
                        image: UIImage(systemName: "star.fill"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        dataSource = self
        delegate = self
        
        let firstSlide = createSlide(index: 0)
        setViewControllers([firstSlide], direction: .forward, animated: true)
        
        setupPageControl()
        setupButton()
    }
    
    func createSlide(index: Int) -> SlideViewController {
        let slideVC = SlideViewController()
        slideVC.slide = slides[index]
        slideVC.index = index
        return slideVC
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupButton() {
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .systemBlue
        nextButton.layer.cornerRadius = 12
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func updateButtonTitle() {
        if currentPage == slides.count - 1 {
            nextButton.setTitle("Get Started", for: .normal)
            nextButton.backgroundColor = .systemGreen
        } else {
            nextButton.setTitle("Next", for: .normal)
            nextButton.backgroundColor = .systemBlue
        }
    }
    
    @objc func nextTapped() {
        if currentPage == slides.count - 1 {
            goToMainApp()
        } else {
            currentPage += 1
            let nextSlide = createSlide(index: currentPage)
            setViewControllers([nextSlide], direction: .forward, animated: true)
            pageControl.currentPage = currentPage
            updateButtonTitle()
        }
    }
    

    func goToMainApp() {
        UserDefaults.standard.set(true, forKey: "onboardingDone")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainNavVC = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
        mainNavVC.modalPresentationStyle = .fullScreen
        present(mainNavVC, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let slideVC = viewController as? SlideViewController,
              slideVC.index > 0 else { return nil }
        return createSlide(index: slideVC.index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let slideVC = viewController as? SlideViewController,
              slideVC.index < slides.count - 1 else { return nil }
        return createSlide(index: slideVC.index + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed,
           let currentVC = pageViewController.viewControllers?.first as? SlideViewController {
            currentPage = currentVC.index
            pageControl.currentPage = currentPage
            updateButtonTitle()
        }
    }
    
}

