require 'spec_helper'

describe Mongoid::Roles::Subject do
  before(:each) do
    @bob = User.new
    @proj = Project.new
  end
  
  context 'has_role!' do  
    it 'should set role' do
      @bob.has_role?(:manager, @proj).should be_false
      @bob.has_role!(:manager, @proj)
      @bob.has_role?(:manager, @proj).should be_true
      
      @bob.has_role?(:manager).should be_false
      @bob.has_role!(:manager)
      @bob.has_role?(:manager).should be_true
    end
  end
  
  context 'has_no_roles!' do
    it 'should remove all roles' do
      @bob.has_role!(:manager)
      @bob.has_role!(:manager, @proj)
      @bob.roles.count.should == 2
      
      @bob.has_no_roles!
      @bob.roles.count.should == 0
    end
  end
  
  context 'has_no_role!' do
    it 'should remove particular role' do
      @bob.has_role!(:manager)
      @bob.has_role!(:manager, @proj)
    
      @bob.has_role?(:manager).should be_true
      @bob.has_no_role!(:manager)
      @bob.has_role?(:manager).should be_false
    
      @bob.has_role?(:manager, @proj).should be_true
      @bob.has_no_role!(:manager, @proj)
      @bob.has_role?(:manager, @proj).should be_false
    end
  end
  
  context 'has_roles_for?' do
    it 'should check if role exists for object' do      
      @bob.has_roles_for?(@proj).should be_false
      @bob.has_role!(:manager, @proj)
      @bob.has_roles_for?(@proj).should be_true
    end
  end
  
  context 'has_role_for?' do
    it 'should do the same as has_roles_for?' do
      @bob.has_roles_for?(@proj).should be_false
      @bob.has_role!(:manager, @proj)
      @bob.has_roles_for?(@proj).should be_true
    end
  end
  
  context 'roles_for' do
    it 'should return all roles for object' do
      proj2 = Project.new
      
      @bob.has_role!(:manager, @proj)
      @bob.has_role!(:leader, @proj)
      @bob.has_role!(:manager, proj2)
      
      @bob.roles_for(@proj).count.should == 2
    end
  end
  
  context 'has_no_roles_for!' do
    it 'should remove roles for object' do 
      proj2 = Project.new
      
      @bob.has_role!(:manager, @proj)
      @bob.has_role!(:leader, @proj)
      @bob.has_role!(:manager, proj2)
      
      @bob.has_no_roles_for!(@proj)
      
      @bob.roles.count.should == 1
    end
  end
end