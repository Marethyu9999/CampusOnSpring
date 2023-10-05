package org.unidue.campusfm.queerzard.cms.database.services.impl;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.unidue.campusfm.queerzard.cms.database.dao.ArticleEntity;
import org.unidue.campusfm.queerzard.cms.database.dao.UserEntity;
import org.unidue.campusfm.queerzard.cms.database.repositories.ArticleRepository;
import org.unidue.campusfm.queerzard.cms.database.services.interfaces.ArticleService;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.UUID;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private EntityManager entityManager;

    @Autowired
    @Getter private ArticleRepository articleRepository;

    @Override
    public List<ArticleEntity> findAll() {
        return articleRepository.findAll();
    }

    @Override
    public List<ArticleEntity> findAll(int pageNumber, int pageSize) {
        return articleRepository.findAll(PageRequest.of(pageNumber, pageSize)).getContent();
    }

    @Override
    public ArticleEntity update(ArticleEntity article) {
        return articleRepository.save(article);
    }

    @Override
    public ArticleEntity addArticle(ArticleEntity article) {
        return articleRepository.save(article);
    }

    @Override
    public boolean articleExists(ArticleEntity article) {
        return articleExistsById(article.getId());
    }

    @Override
    public boolean articleExistsById(String id) {
        return articleRepository.existsArticleEntityById(id);
    }

    @Override
    public ArticleEntity getArticleByPostId(String postId) {
        return articleRepository.findArticleEntityById(postId);
    }

    @Override
    public List<ArticleEntity> getArticlesByAuthor(UserEntity user) {
        return articleRepository.findAllPublishedByAuthor(user);
    }

    @Override
    public List<ArticleEntity> getArticlesWithString(String regex) {
        return null;
    }

    @Override
    public List<ArticleEntity> findAllPublishedArticles(int pageNumber, int pageSize) {
        return articleRepository.findAllByPublishedTrue(PageRequest.of(pageNumber, pageSize));
    }

    @Override
    public List<ArticleEntity> findArticlesByQuery(String query, int pageNumber, int pageSize) {
        return articleRepository.findArticlesByQuery(query, PageRequest.of(pageNumber, pageSize));
    }

    @Override
    public List<ArticleEntity> findAllArticlesByQuery(String query) {
        return articleRepository.findAllArticlesByQuery(query);
    }

    @Override
    public void delete(ArticleEntity article) {
        articleRepository.delete(article);
    }

    @Override
    public long count() {
        return articleRepository.count();
    }
}
