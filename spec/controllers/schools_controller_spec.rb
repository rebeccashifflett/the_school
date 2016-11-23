require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  let(:school) { School.create(name: 'Schoolio', students: 400, open: true) }
  #{ FactoryGirl.create(:school)}


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the schools instance variable' do
      get :index
      expect(assigns(:schools)).to eq([])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has schools in the schools instance variable' do
      3.times do |index|
        School.create(
          name: "name_#{index}",
          students: '10',
          open: true
        )
      end
      get :index
      expect(assigns(:schools).length).to eq(3)
      expect(assigns(:schools).last.name).to eq('name_2')
    end
end

  describe "GET #new" do
    it "returns http success" do
    get :new
    expect(response).to have_http_status(:success)
  end
  it "renders the new template" do
    get :new
    expect(response).to render_template(:new)
  end
  it "Sets the new instance variable" do
    get :new
    expect(assigns(:school)).to_not eq(nil)
    expect(assigns(:school).id).to eq(nil)
  end
end

  describe "POST #create" do
    before(:each) do
      @school_params = {
        school: {
        name: 'Test Country',
        students: '10',
        open: true
     }
    }
  end
  it "sets the school instance variable" do
    post :create, @school_params
    expect(assigns(:school)).to_not eq(nil)
    expect(assigns(:school).name).to eq(@school_params[:school][:name])
  end
  it "creates a new school" do
    expect(School.count).to eq(0)
    post :create, @school_params
    expect(School.count).to eq(1)
    expect(School.first.name).to eq(@school_params[:school][:name])
  end
end

describe "GET #show" do
    before(:each) do
      @school = School.create(name: 'Some School', students:  100, open: true)
    end
    it "returns http success" do
      get :show, id: @school.id
      expect(response).to have_http_status(:success)
    end
    it "renders the show template" do
      get :show, id: @school.id
      expect(response).to render_template(:show)
    end
    it "set the school instance variable" do
      get :show, id: @school.id
      expect(assigns(:school).name).to eq(@school.name)
    end
  end

describe "GET #edit" do

    it "returns http success" do
      get :edit, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, id: school.id
      expect(response). to render_template(:edit)
    end

    it "sets school instance variable" do
      get :edit, id: school.id
      expect(assigns(:school).id).to eq(school.id)
    end
end

describe 'DELETE #destroy' do
    it "sets the school instance variable" do
      delete :destroy, id: school.id
      expect(assigns(:school)).to eq(school)
    end
    it "destroys the school" do
      expect(School.count).to eq(0)
      delete :destroy, id: school.id
      expect(School.count).to eq(0)
    end
    it "sets the flash message" do
      delete :destroy, id: school.id
      expect(flash[:success]).to eq("School deleted!")
    end
    it "redirects to index path after destroy" do
      delete :destroy, id: school.id
      expect(response).to redirect_to(schools_path)
    end
  end


  describe 'PUT #update' do
    it 'sets the school instance variable' do
      put :update, { id: school.id, school: { name: 'name' }}
      expect(assigns(:school).id).to eq(school.id)
    end

    it 'updates the school' do
      put :update, { id: school.id, school: { name: 'new name' }}
      expect(school.reload.name).to eq('new name')
    end

    it 'sets a flash message on success' do
      put :update, { id: school.id, school: { name: 'name' }}
      expect(flash[:success]).to eq('School Updated!')
    end

    it 'redirects to show on success' do
      put :update, { id: school.id, school: { name: 'name' }}
      expect(response).to redirect_to(school_path(school.id))
    end

    describe 'update failures' do
      it 'renders edit on fail' do
        put :update, { id: school.id, school: { name: 'Schoolio', students: 200, open: true} }
        expect(response).to render_template [:edit]
      end

      it 'sets flash message on error' do
        put :update, { id: school.id, school: { name: 'Schoolio', students: 200, open: true } }
        expect(flash[:error]).to eq('School failed to update')
      end
    end
  end
end
