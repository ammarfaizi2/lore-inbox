Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbQKHJTa>; Wed, 8 Nov 2000 04:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbQKHJTU>; Wed, 8 Nov 2000 04:19:20 -0500
Received: from [202.103.134.10] ([202.103.134.10]:45507 "HELO mx1.netease.com")
	by vger.kernel.org with SMTP id <S129043AbQKHJTM>;
	Wed, 8 Nov 2000 04:19:12 -0500
Date: Wed, 8 Nov 2000 17:17:33 +0800
From: cnchun <asdf2970@netease.com>
Reply-To: asdf2970@netease.com
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: When I use kernel-2.4.0-test10,I got this problem on my server.
X-mailer: FoxMail 3.0 beta 2 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20001108092403.0E0351C404EAA@mx1.netease.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The boot messages is below:
.....
megaraid:v107 (december 22.1999)
megaraid:found 0x8086:0x1960:in 03:0b.1
megaraid:board configure for I2O .ignoring this card.reconfigure the card
megaraid:in the bios for "mass storage" to use it with the driver.
linux pcmcia card services 3.1.22
	options:[pci][cardbus][pw]
i2o_scsi.c:version 0.0.1
chain_pool:0bytes@f7be0b60
(512 byte buffers X4 can_querue X0 i2o controllers)
net4:linux tcp/ip 1.0 for net4.0
ip protocols:icmp,udp,tcp,igmp
ip:routing cache hash table of 16384 buckets. 128Kbytes
tcp:hash tables configured (establiched 131072 bind 65536)
net4:unix domain socket 1.0/smp for linux net4.
kmen_create:forcing size word alignment.nfs_fh
ds:no socket drivers locaded!
vfs:cannot open root device "801" or 08:01
Please append a correct "root=" boot option
...........
kernel panic....

The kernel-2.2.18 can run on my server very well.My server is DELL 6450/550 with 4G MEM and 4 CPU,I also have 2 Raid-5(DELL
Powervault 210s) with 1.6 TG storage.


please help me!







                             

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
