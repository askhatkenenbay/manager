package olibek.manager;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("modelRepository")
public interface ModelRepository extends CrudRepository<MyModel,Integer> {
    List<MyModel> findByPhone(int phone);
    List<MyModel> findAll();
}
