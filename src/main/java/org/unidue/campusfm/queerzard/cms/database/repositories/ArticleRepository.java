package org.unidue.campusfm.queerzard.cms.database.repositories;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.unidue.campusfm.queerzard.cms.database.dao.ArticleEntity;
import org.unidue.campusfm.queerzard.cms.database.dao.UserEntity;

import java.util.List;
import java.util.UUID;

public interface ArticleRepository extends JpaRepository<ArticleEntity, Long> {

    List<ArticleEntity> findArticleEntitiesByUserEntity(UserEntity user);
    ArticleEntity findArticleEntityById(String postId);

    @Query("SELECT a FROM ArticleEntity a WHERE a.published = true AND a.views >= :minViews")
    List<ArticleEntity> findPopularArticlesWithMinViews(int minViews);

    @Query("SELECT a FROM ArticleEntity a WHERE a.published = true")
    List<ArticleEntity> findAllPublishedArticles();

    @Query("SELECT a FROM ArticleEntity a WHERE a.published = false")
    List<ArticleEntity> findAllUnpublishedArticles();

    @Query("SELECT a FROM ArticleEntity a WHERE a.published = false AND a.userEntity = :user")
    List<ArticleEntity> findAllUnpublishedByAuthor(UserEntity user);

    @Query("SELECT a FROM ArticleEntity a WHERE a.published = true AND a.userEntity = :user")
    List<ArticleEntity> findAllPublishedByAuthor(UserEntity user);

    List<ArticleEntity> findAllByPublishedTrue(Pageable pageable);

    List<ArticleEntity> findAllByUserEntityAndPublishedIsTrue(UserEntity user);

    @Query("SELECT a FROM ArticleEntity a WHERE a.published = true AND ( " +
            "LOWER(a.tags) LIKE LOWER(concat('%', :query, '%')) OR " +
            "LOWER(a.category) LIKE LOWER(concat('%', :query, '%')) OR " +
            "LOWER(a.title) LIKE LOWER(concat('%', :query, '%')) OR " +
            "LOWER(a.contents) LIKE LOWER(concat('%', :query, '%')) )")
    List<ArticleEntity> findArticlesByQuery(@Param("query") String query, Pageable pageable);

    @Query("SELECT a FROM ArticleEntity a WHERE a.published = true AND ( " +
            "LOWER(a.tags) LIKE LOWER(concat('%', :query, '%')) OR " +
            "LOWER(a.category) LIKE LOWER(concat('%', :query, '%')) OR " +
            "LOWER(a.title) LIKE LOWER(concat('%', :query, '%')) OR " +
            "LOWER(a.contents) LIKE LOWER(concat('%', :query, '%')) )")
    List<ArticleEntity> findAllArticlesByQuery(@Param("query") String query);

    boolean existsArticleEntityById(String postId);

}
