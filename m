Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131149AbRCGSsi>; Wed, 7 Mar 2001 13:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRCGSs3>; Wed, 7 Mar 2001 13:48:29 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:25261 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S131149AbRCGSsM>; Wed, 7 Mar 2001 13:48:12 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac13 es1370.o module and verbose bug reporting
In-Reply-To: <20010307124136.A6651@middle.of.nowhere>
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 07 Mar 2001 19:47:53 +0100
In-Reply-To: thunder7@xs4all.nl's message of "Wed, 7 Mar 2001 11:41:36 GMT"
Message-ID: <qww4rx5quue.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Persephone)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 thunder7> depmod: *** Unresolved symbols in /lib/modules/2.4.2-ac13/kernel/drivers/sound/es1370.o
 thunder7> depmod:         do_BUG
Same here. It happens with many more modules. ac12 was OK. 

./misc/cipcb.o (not part of kernel)
./kernel/drivers/block/loop.o
./kernel/drivers/net/ppp_generic.o
./kernel/drivers/net/3c59x.o
./kernel/drivers/net/ppp_async.o
./kernel/drivers/net/3c509.o
./kernel/drivers/net/8139too.o
./kernel/drivers/net/tun.o
./kernel/drivers/net/irda/nsc-ircc.o
./kernel/drivers/net/irda/smc-ircc.o
./kernel/drivers/net/tulip/tulip.o
./kernel/drivers/sound/via82cxxx_audio.o
./kernel/drivers/sound/emu10k1/emu10k1.o
./kernel/drivers/usb/usb-ohci.o
./kernel/fs/isofs/isofs.o
./kernel/fs/fat/fat.o
./kernel/fs/binfmt_misc.o
./kernel/fs/affs/affs.o
./kernel/fs/autofs/autofs.o
./kernel/fs/autofs4/autofs4.o
./kernel/fs/cramfs/cramfs.o
./kernel/fs/reiserfs/reiserfs.o
./kernel/fs/nfsd/nfsd.o
./kernel/fs/ramfs/ramfs.o
./kernel/fs/smbfs/smbfs.o
./kernel/fs/udf/udf.o
./kernel/net/ipv4/netfilter/ip_nat_ftp.o
./kernel/net/ipv4/netfilter/ip_queue.o
./kernel/net/irda/irda.o
./kernel/net/irda/irlan.o
./kernel/net/irda/ircomm/ircomm-tty.o
./kernel/net/irda/ircomm/ircomm.o
./kernel/net/irda/irlan/irlan.o
./kernel/net/irda/irnet/irnet.o

                                                Petr
-- 
Exercise caution in your daily affairs.
