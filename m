Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271833AbRICV60>; Mon, 3 Sep 2001 17:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRICV6R>; Mon, 3 Sep 2001 17:58:17 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:26004 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S271833AbRICV6A>;
	Mon, 3 Sep 2001 17:58:00 -0400
Date: Mon, 3 Sep 2001 23:58:13 +0200
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac7
Message-ID: <20010903235813.F26627@khan.acc.umu.se>
In-Reply-To: <20010903201813.A8730@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010903201813.A8730@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Mon, Sep 03, 2001 at 08:18:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 08:18:13PM +0100, Alan Cox wrote:
> 
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/
> 
> 		 Intermediate diffs are available from
> 			http://www.bzimage.org
> 
> 2.4.9-ac7
> o	Add another 1885 ident				(Leon)
> o	Mention G450 in the 200/400 DRI			(Pavel Roskin)
> o	Fix non PCI aic7xxx oops			(me)
> o	Correct centaur chip detection			(Keith Owens)
> o	Correct Dell cable detection			(me)
> o	Fix usb storage warning				(Christoph Hellwig)
> o	Fix symbol clash between core and pwc		(Christoph Hellwig)
> o	Comment out the visws				(Christoph Hellwig)
> o	Small alpha build fix				(Ricky Beam)
> o	NFS client update				(Trond Myklebust)
> o	SE401 update					(Jeroen Vreeken)
> o	Check proc/modules before querying it in	(André Dahlqvist)
> 	ver_linux
> o	Add hppa to unaligned list for reiserfs		(Jurriaan)
> o	i2c Config.in fix				(Christoph Hellwig)
> o	LVM 32/64bit sort out				(Patrick Caulfield)
> o	Softirq update/fixups				(Andrea Arcangeli)
> o	Add arch_init_modules hook			(Keith Owens)
> o	Update slab cache to do LIFO handling and clean	(Andrea Arcangeli)
> 	up code somewhat
> o	Ethtool and alias fix				(Arjan van de Ven)
> o	Self adjusting syscall table filler		(Andrea Arcangeli)
> o	Configure.help typo fix				(David Weinehalle)
                                                               ^^^^^^^^^^
I felt I just had to... :-)


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
