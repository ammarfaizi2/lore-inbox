Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274278AbRIYAZp>; Mon, 24 Sep 2001 20:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274277AbRIYAZY>; Mon, 24 Sep 2001 20:25:24 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:2781 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S274272AbRIYAZW>;
	Mon, 24 Sep 2001 20:25:22 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Tim Moore <timothymoore@bigfoot.com>
Date: Mon, 24 Sep 2001 20:25:42 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[06]: Linux Kernel 2.2.20-pre10 Initial Impressions
Reply-to: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3BAF96C6.14500.316861@localhost>
In-Reply-To: <3BAF9F68.4EFBC73B@bigfoot.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tim,

Thank you so much for your offer.

If you get a chance please refer to my posting yesterday where I
actually detailed the results of my testing and the steps I used.  If
you need further details feel free to ask.

My results seem to suggest one interesting behaviour.  At this point
I am not sure if it is part kernel, part Netscape or all Netscape.  I
would lean towards it not being all Kernel, but I could be really
wrong given my very limited knowledge of the kernel.  Just my
professional QA/Testing opinion with varied my technical background.


Regards,

John L. Males
Willowdale, Ontario
Canada
24 September 2001 20:25
mailto:jlmales@softhome.net


Date sent:      	Mon, 24 Sep 2001 14:02:32 -0700
From:           	Tim Moore <timothymoore@bigfoot.com>
Organization:   	Yoyodyne Propulsion Systems, Inc.
To:             	jlmales@softhome.net
Copies to:      	linux-kernel@vger.kernel.org
Subject:        	Re: Linux Kernel 2.2.20-pre10 Initial Impressions

> "John L. Males" wrote:
> > ...
> > Ok, I finially had a chance to compile the 2.2.20-pre10 Kernel
> > and run it though some basic paces.  I need to do more specific A
> > vs b (against the 2.2.19 Kernel), but it seems there are some
> > performance issues.  It is seems especially obvious with Netscape
> > 4.78.  I also had a odd Xfree error, that may have had some
> > relationship to the performance issue. ...
> 
> FWIW, I've been using ns 4.78 since August 20 on the listed kernels
> with no noticable change.  All kernels have Andre's IDE patch.
> 
> If you have a specific test script I can give it a run.
> 
> 2.2.19pre17, 2.2.20pre{6,9,10}
> XFree86-3.3.6-29 (SVGA driver)
> ide.2.2.19.05042001.patch
> communicator-v478-us.x86-unknown-linux2.2.tgz
> 
> System is Athlon 850 (CONFIG_M686=y) on an Abit KA7.
> 
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391
> (rev 02) 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device
> 8391 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo
> Super] (rev 22) 00:07.1 IDE interface: VIA Technologies, Inc.
> VT82C586 IDE [Apollo] (rev 10) 00:07.4 Host bridge: VIA
> Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
> 
> rgds,
> tim.
> --


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO6/c/uAqzTDdanI2EQJjaACfXE49KYj/PSLGlXh18iYJTytyRmYAoK0C
hIiTpYo2vu1OHKYb5YPKv8qc
=Nz85
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
