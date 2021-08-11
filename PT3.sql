	
	use Ecommerce
	--Pjesa |||
				/*1*/	select * 
					from Konsumatori 
					where emri  like '%l';

                /*2*/ 
				      select Distinct Mbiemri
					  from Konsumatori

                /*3*/ 
				     select Emri_Produktit,Cmimi
					 from Produkti
					 where Cmimi<25
				      
                
                /*4*/ 
				     select Emri_Produktit,Cmimi
					 from Produkti
					 where Cmimi>=25


                
                /*5*/ 
				     select *
					 from Jep
					 where Vula_kohore='12:30'



					 
                /*6*/ 
				     select Emri_Kompanis,Pagesat,Koha_Dergimit
					 from Furnizuesi
					 where Koha_Dergimit between '2020-12-10' and '2021-01-15'



			   /*7*/
			         select Furnizuesi_ID,Emri_Kompanis,count(Pagesat) 
					 from Furnizuesi 
					 group by  Furnizuesi_ID,Emri_Kompanis

			   /*8*/
			         select Furnizuesi_ID,Emri_Kompanis,MAX(Pagesat)[SHUMA]
					 from Furnizuesi 
                     group by Furnizuesi_ID,Emri_Kompanis
					 order by [SHUMA] desc
					 

			   /*9*/
			         select d.Porosia_ID,AVG(d.Cmimi)[SHUMA]
					 from Detajet_e_Porosis d
					 where d.Porosia_ID=008
                     group by   d.Porosia_ID,d.Sasia
					

			    /*10*/  select Furnizuesi_ID,Emri_Kompanis,sum(Pagesat)
					 from Furnizuesi f
					 where f.Furnizuesi_ID>3 and f.Furnizuesi_ID<=4
					 group by Furnizuesi_ID,Emri_Kompanis



					/*1*/
					select *
					from Furnizuesi f INNER JOIN Produkti p
					on f.Furnizuesi_ID=p.FurnizuesiID
					where f.Furnizuesi_ID=5


					/*2*/
					select *
					from Produkti p RIGHT JOIN Kategoria k
					on p.KategoriaID=k.Kategoria_ID
					where Kategoria_ID=444

					/*3*/
					select *
					from Porosia p LEFT JOIN Detajet_e_Porosis dp
					on p.PorosiaID=dp.Porosia_ID
					Where Porosia_ID=0008

					/*4*/
					select a.Admini_Emri,a.Admini_Username,p.Produkti_ID
					from Admini a RIGHT join Produkti p 
					on a.Admini_ID=p.AdminiID


					/*5*/
					select f.Emri,f.Financieri_ID,k.FaturimiID,k.KonsumatoriID
					from Kontrollon k left join Financieri f
					on k.FinancieriID=f.Financieri_ID

					/*6*/
					select sh.Shporta_ID,sh.Numri_Produkteve,k.ProduktiID
					from Shporta sh inner join Ka_ne_Shport k
					on sh.Shporta_ID=k.ShportaID

					/*7*/
					select *
					from Porosia p right join Detajet_e_Porosis dp
					on p.PorosiaID=dp.Porosia_ID
					where Dp.Cmimi<80


					/*8*/
					select p.PorosiaID,t.Emri_Kompanis,t.Telefoni[Kontakto transportuesin]
					from Porosia p left join Transportues t
					on p.TransportuesiID=t.Transportuesi_ID
					where t.Transportuesi_ID=14


                  /*1*/
				       select *
					   from Ka_Info_Faturimi kf join Konsumatori k 
					   on kf.KonsumatoriID=k.Konsumatori_ID join InforamcioneFaturimi iff
					    on  iff.Faturimi_ID=kf.FaturimiID

				/*2*/
				       select *
					   from Ka_Info_Faturimi kf join Konsumatori k 
					   on kf.KonsumatoriID=k.Konsumatori_ID join InforamcioneFaturimi iff
					    on  iff.Faturimi_ID=kf.FaturimiID
						where k.Konsumatori_ID=2

				/*3*/
				       select *
					   from Ka_ne_Shport ks join Konsumatori k 
					   on k.Konsumatori_ID=ks.KonsumatoriID join Shporta sh
					    on  ks.ShportaID=sh.Shporta_ID
						where k.Konsumatori_ID=11


               /*4*/
			        select *
					from Financieri f join Kontrollon k 
					on f.Financieri_ID=k.FinancieriID 
					join Konsumatori kk
					on k.KonsumatoriID=kk.Konsumatori_ID
					where f.Financieri_ID=8522



					/*1*/
					select p.Emri_Produktit,dp.ProduktiID,dp.Cmimi
					from Produkti p join Detajet_e_Porosis dp
					on p.Produkti_ID=dp.ProduktiID
					where dp.Cmimi<(select max(o.Cmimi)
					from Produkti o)


					/*2*/
					select p.Emri_Produktit,p.Pershkrimi_Produktit
					from Produkti p
					where p.Produkti_ID not in(select  distinct dp.ProduktiID
												from   Detajet_e_Porosis dp  )


                    /*3*/
					SELECT p.Emri_Produktit, (select sum(dp.Sasia)
					                          from Detajet_e_Porosis dp
											  where dp.ProduktiID=p.Produkti_ID) as [Produkte te shitura]
					
					from Produkti p
					order by [Produkte te shitura]


					/*4*/
					SELECT p.Produkti_ID,p.Pershkrimi_Produktit
					from Produkti p
					where p.Produkti_ID Exists
					                          (select dp.ProduktiID, sum(dp.Sasia) [Produkte te shitura]
					                          from Detajet_e_Porosis dp join Produkti p
											  on dp.ProduktiID=p.Produkti_ID
											  group by dp.ProduktiID
											  having sum(dp.Sasia)>10) 

					--Qmimi minimal per secilen Porosi
					/*5*/
					select p.PorosiaID,dp.ProduktiID,dp.Cmimi
					from Porosia p join Detajet_e_Porosis dp
					on p.PorosiaID=dp.Porosia_ID
					where dp.Cmimi in

					(select min(dp.Cmimi)
					from Detajet_e_Porosis dp
					group by dp.Porosia_ID)
					order by p.PorosiaID desc


					--Ku furnizuesi eshte me id 5
					/*6*/
					select p.Emri_Produktit,p.Cmimi,p.AdminiID,f.Emri_Kompanis
					from Produkti p , Admini a,Furnizuesi f
					where p.AdminiID=a.Admini_ID and p.FurnizuesiID=f.Furnizuesi_ID
				and f.Furnizuesi_ID =
				
			       ( select f.Furnizuesi_ID
					from Furnizuesi f
					where f.Furnizuesi_ID=5)

					--Konsumatoret te cilet kane porosite dhe jane nga nje vend i caktuar
					(select ip.Shteti
					from InformacionePersonale ip
					where ip.Shteti like 'Spanje')

					select m.Emri,m.AdminiID [Mbikqyre],m.KeshilluesiMbikqyres
					from Mbikqyresi m , Admini a
				    where a.Admini_ID=m.AdminiID
					and m.KeshilluesiMbikqyres in (convert(int,(select m.Emri
					       from Mbikqyresi m
						   where m.KeshilluesiMbikqyres=86)))

						   --Adminat qe bejne te njejten pune me adminin 65 
						   /*7*/
						   select  p.Emri_Produktit,a.Admini_ID
						   from Produkti p join Admini a
						   on p.AdminiID=a.Admini_ID
						   where a.Admini_ID=(select p.AdminiID [Id te llojit te punes]
						                      from Produkti p
											  where p.Produkti_ID=1018)

                          /*8*/
						  select k.FaturimiID,kk.Konsumatori_ID,kk.Emri,f.Financieri_ID,f.Emri
						  from Kontrollon k join Financieri f
						  on f.Financieri_ID=k.FinancieriID
						  join Konsumatori kk
						  on kk.Konsumatori_ID=k.KonsumatoriID
						  where f.Financieri_ID in(select k.FinancieriID
						                            from Kontrollon k
						                                    )

                      --Detajet e produkteve me cmim me te vogel se Kepucet Solomon
                       /*9*/
					   select p.Emri_Produktit,p.Pershkrimi_Produktit,p.Cmimi
					   from Produkti p
					   where p.Cmimi <all(select pp.Cmimi
					                       from Produkti pp 
										   where pp.Produkti_ID IN(SELECT ppp.Produkti_ID
										                           FROM Produkti ppp
																   where ppp.Emri_Produktit like '%on'
										                            ))


                     /*10*/
					 select top 10 k.Emri,k.Mbiemri,
					 numriporosive=
					 (select count(j.KonsumatoriID)
					 from Jep j
					 where j.KonsumatoriID=k.Konsumatori_ID)
					 from Konsumatori k
					 Order by  numriporosive desc


					 /*11*/
					 	go
					with ProdukteShitura as (select dp.ProduktiID, sum(dp.Sasia)[PSH]
					                          from Detajet_e_Porosis dp
											  group by dp.ProduktiID)

                     select *
					 from Produkti p join ProdukteShitura psh
					 ON p.Produkti_ID=psh.ProduktiID
					 ORDER BY PSH DESC

					 /*12*/
					 go
					 with ProduktiShiturr as(Select dp.ProduktiID,sum(dp.Sasia)[ProduktetTeShituraMbi5]
					                         from Detajet_e_Porosis dp
											 group by dp.ProduktiID
											 having sum(dp.Sasia)>5)

                      select p.Emri_Produktit,pp.ProduktetTeShituraMbi5
					  from Produkti p join ProduktiShiturr pp
					  on p.Produkti_ID=pp.ProduktiID
					  order by ProduktetTeShituraMbi5 desc

					  /*13*/
					  create view ProdukteMbi5 as (Select dp.ProduktiID,sum(dp.Sasia)[ProduktetTeShituraMbi5]
					                         from Detajet_e_Porosis dp
											 group by dp.ProduktiID
											 having sum(dp.Sasia)>5)


               
			          /*14*/
					  create view TotaliPerFurnizues as(Select f.Emri_Kompanis, sum(f.Pagesat)[ShumaTotale]
					                                     from Furnizuesi f
														 group  by f.Emri_Kompanis)


														 select * from TotaliPerFurnizues

														  

                     /*1*/
					 select ka.KonsumatoriID,ka.ProduktiID
					 from Ka_ne_Shport ka
					 Where ka.KonsumatoriID=6
					 INTERSECT
					  select ka.KonsumatoriID,ka.ProduktiID
					 from Ka_ne_Shport ka
					 Where ka.KonsumatoriID=7

					 /*2*/
					select ka.KonsumatoriID,ka.ProduktiID
					 from Ka_ne_Shport ka
					 Where ka.KonsumatoriID=6
					EXCEPT
					  select ka.KonsumatoriID,ka.ProduktiID
					 from Ka_ne_Shport ka
					 Where ka.KonsumatoriID=7


					 --Shfaqi produktet nga furnizuesi 5 dhe jo nga furnizuesi 6
					 select f.Emri_Kompanis
					 from Furnizuesi f
					 where  f.Furnizuesi_ID not  in(select *
					                                from Produkti p
											        where p.FurnizuesiID=5)
						union

                    select f.Emri_Kompanis
					 from Furnizuesi f
					 where  f.Furnizuesi_ID  in (select *
					                             from Produkti p
											     where p.FurnizuesiID=11)
										
					                                   

              /*1*/
			  create Proc TeDhenatPers
			  as
			  begin
			  set nocount on
			  select k.Emri,k.Mbiemri
			  from Konsumatori k
			  end

			  /*2*/
			  create Proc Pagesat
			  as 
			  begin
			  set nocount on
			  select f.Emri_Kompanis,f.Pagesat
			  from Furnizuesi f
			  end

			  /*3*/
			alter proc GjejSipasID(
			  @myName varchar(20)
			  )
			  as 
			  begin
			  set nocount on
			  select *
			  from Konsumatori k
			  where k.Emri like @myName
			  end
			  GjejSipasID 'jeton'

			  /*4*/
			  alter proc Totali(
			  @ProduktiSipasID int,
			  @EmriP varchar(20) out,
			  @Pershkrimi varchar(50) out,
			  @Cmimi money out
			  )
			  as
			  begin
			  set nocount on
			  select  @EmriP=p.Emri_Produktit,  @Pershkrimi=p.Pershkrimi_Produktit, @Cmimi=p.Cmimi
			  from Produkti p
			  where p.Produkti_ID=@ProduktiSipasID
			  end
  
           declare @EmriP varchar(20),@Pershkrimi varchar(50),  @Cmimi money
		   exec Totali
		   1018,
		   @EmriP out,
		   @Pershkrimi out,
		   @Cmimi out 
		   print 'Te dhenat nga produkti me ID' +@EmriP+ ' - ' + @Pershkrimi + ' - ' +convert(varchar,@Cmimi);

		   /*5*/
		  alter proc EkzekutoProduktin(
		   @myId int
		    )
		as
		begin
		set nocount on
		 declare @EmriP varchar(20),@Pershkrimi varchar(50),  @Cmimi money
		   exec Totali
		   1018,
		   @EmriP out,
		   @Pershkrimi out,
		   @Cmimi out 
		   print 'Te dhenat nga produkti me ID' +@EmriP+ ' - ' + @Pershkrimi + ' - ' + convert(varchar,@Cmimi);
		   end

		  exec  EkzekutoProduktin @myId=1018

		  /*6*/
		 ALTER proc SaProdukteKaNeShport(
		  @ID int,
		  @NrProd int=null
		  )
		  as
		BEGIN


		 if(@ID=11)
		 begin
		 set @NrProd=(select count(*) 
		               from Ka_ne_Shport k  where k.KonsumatoriID= @ID )
          print 'Numri i produkteve ne shport nga Konsumatori me ID 11 eshte : ' +convert(varchar,@NrProd);
		  end
		   
		   ELSE

		  if(@ID=8)
		 begin
		 set @NrProd=(select count(*) 
		               from Ka_ne_Shport k  where k.KonsumatoriID= @ID )
          print 'Numri i produkteve ne shport nga Konsumatori me ID 8 eshte : ' +convert(varchar,@NrProd);
		  end

		  else
		  print 'Gabim'
		  END

		  SaProdukteKaNeShport 11


		 /*7*/
		 --Cilat Produkte Kualifikohen per zbritje
	alter proc ProduktiPerZbrijte(
		 @Pid int =null,
		 @Cmimi money=null
		 )
		 as
		 begin
		 select p.Emri_Produktit,p.KategoriaID,QMIMI=(CASE 
		                                                      WHEN @Cmimi BETWEEN 10.00 AND 25.00 THEN'Nuk kualifikohet per zbritje'
															   WHEN @Cmimi BETWEEN 30.00 AND 125.00 THEN 'Kualifikohet per zbrijte' 
															   else null
															   end
															    )
		                                                       from Produkti p
															   where p.Produkti_ID=@Pid
		 END

ProduktiPerZbrijte '1018','30.00'


/*8*/
create proc MesatarjaMoshesFianciereve
as
begin
select avg(f.Mosha)
from Financieri F
end

/*9*/
create proc ShtetiNGA(
@IDF int out,
@Shteti varchar(50) 
)
as 
begin

select @IDF=iff.Faturimi_ID
from InforamcioneFaturimi iff
where iff.Adresa_Faturimit=@Shteti
END

declare @IDF int
execute ShtetiNGA
'Spanje/Malaga',
@IDF out
Print 'Faturat qe vin nga jane' +convert(varchar,@IDF);
