module Autobuild
    def self.dummy(spec)
        DummyPackage.new(spec)
    end

    class DummyPackage < Package
        def installstamp
            "#{srcdir}/#{STAMPFILE}"
        end
	
        def initialize(*args)
            super
        end

        def import(only_local=false)
        end

        def prepare
            %w{import prepare build doc}.each do |phase|
                task "#{name}-#{phase}"
                t = Rake::Task["#{name}-#{phase}"]
                def t.needed?; false end
            end
            task(installstamp)
            t = Rake::Task[installstamp]
            def t.needed?; false end

            super
        end
    end
end
    

