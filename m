Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUBIDVl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 22:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUBIDVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 22:21:41 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:54287 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261733AbUBIDVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 22:21:40 -0500
Date: Mon, 9 Feb 2004 04:21:36 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IPV4 as module?
In-Reply-To: <20040208212757.GW28571@lug-owl.de>
Message-ID: <Pine.LNX.4.58L.0402090417090.29247@rudy.mif.pg.gda.pl>
References: <20040204200610.GB3802@localhost.localdomain>
 <20040205122921.GB28571@lug-owl.de> <Pine.LNX.4.58L.0402080257060.29247@rudy.mif.pg.gda.pl>
 <20040208212757.GW28571@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Feb 2004, Jan-Benedict Glaw wrote:
[..]
> > PS. Many modern PCs wave now only CD drive .. one CD can fit much 
> > more than kernel image and all kernel modules. So step your quostion path 
> > it will be "much more correct" ask why the hell kernel is (still ?) 
> > modular (?) 8^>
> 
> That's not all correct. You can fit 700 MB data on a CD-ROM, but booting
> is still emulated from a 1.44 MB floppy (or some other floppy/HDD
> images, but many BIOSses won't accept those (or handle them correctly)).

Yes but you can also boot from from CD fron 2.88MB FD image and all this
can be allocated for kernel (+modules for initrd) and all rest CD space
can be allocated as root fs :)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
