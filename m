Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263930AbRGGNBX>; Sat, 7 Jul 2001 09:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRGGNBO>; Sat, 7 Jul 2001 09:01:14 -0400
Received: from tela.iaeste.tuwien.ac.at ([128.130.57.77]:59908 "EHLO
	tela.iaeste.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S263930AbRGGNA4>; Sat, 7 Jul 2001 09:00:56 -0400
Date: Sat, 7 Jul 2001 15:05:14 +0200
From: Albert Weichselbraun <albert+kernel@iaeste.or.at>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: rtl8139 dhcp-autoconfiguration problem
Message-ID: <20010707150514.A7370@iaeste.or.at>
In-Reply-To: <20010707142145.A6988@iaeste.or.at> <3B470009.2BA7C123@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B470009.2BA7C123@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Jul 07, 2001 at 08:26:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001-07-07 at 08:26:49 -0400, Jeff Garzik wrote:
> Can you try 2.4.6 please?
done. 
- sorry, but 2.4.6 doesn't work either.

<dmesg kernel="2.4.6" net="8139too">
...
8139too Fast Ethernet driver 0.9.18-pre4
PCI: Found IRQ 10 for device 00:09.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe0800000, 00:00:21:fa:20:ce, IRQ 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32 Kbytes
TCP: Hash table configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
...
</dmesg>

greets,
  albert

