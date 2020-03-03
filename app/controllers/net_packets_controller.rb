RefreshSpan = 10
class NetPacketsController < ApplicationController
    def index
        @net_packets = NetPacket.all
    end

    def new
        @net_packet = NetPacket.new
    end

    def show
        @net_packet
    end

    def edit
        @net_packet = NetPacket.find(params[:id])
    end

    def mydebug
        ops = Operation.all
        ops.each do |operation|
            puts "debug",operation.pid
        end
        render json: ops
    end

    #due to the adding logic,while the id is smaller,the time must be earlier
    def refresh
        op = Operation.first
        ntime = Time.new
        arr = Array.new
        while op != nil
            if ntime - op[:optime] > RefreshSpan
                puts "if OK"
                op.destroy
                puts "destory ok"
                op = Operation.first
            else
                ops = Operation.all
                ops.each do |operation|
                    packet = NetPacket.find(operation.pid)
                    arr.push packet
                end
                break
            end
        end
        render json: arr
    end

    #search the suitable data by ip or port
    def search
        arr = Array.new
        NetPacket.where(srcip: params[:data]).find_each do |packet|
            arr.push(packet)
        end
        NetPacket.where(srcport: params[:data]).find_each do |packet|
            arr.push(packet)
        end
        NetPacket.where(dstip: params[:data]).find_each do |packet|
            arr.push(packet)
        end
        NetPacket.where(dstport: params[:data]).find_each do |packet|
            arr.push(packet)
        end
        @net_packets = arr
        @searchdata = params[:data]
        render 'search'
    end

    def create
        @net_packet = NetPacket.new(net_packet_params)
        if @net_packet.save
            redirect_to net_packets_path
        else
            render 'new'
        end
    end

    def update
        @net_packet = NetPacket.find(params[:id])
        if @net_packet.update(net_packet_params)
            operation = Operation.new(optime: Time.new,pid: params[:id])
            operation.save
            redirect_to net_packets_path
        else
            render 'edit'
        end
    end

    def destroy
        @net_packet = NetPacket.find(params[:id])
        @net_packet.destroy
        redirect_to net_packets_path
    end

    private
        def net_packet_params
            params.require(:net_packet).permit(:starttime, :stoptime, :srcip, :srcport, :dstip, :dstport, :packets)
        end
end