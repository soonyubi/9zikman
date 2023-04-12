import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {

  constructor(
    @InjectRepository(User) private usersRepository : Repository<User>
  ){}

  async getByEmail(email : string){
    const user = await this.usersRepository.findOne({where:{email}});
    if(user) return user;
    throw new HttpException('User with this email does not exist', HttpStatus.NOT_FOUND);
  }

  async createUser(userData: CreateUserDto){
    const newUser = await this.usersRepository.create(userData);
    await this.usersRepository.save(newUser);
    return newUser;
  }
}
