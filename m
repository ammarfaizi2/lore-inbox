Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTKUIvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTKUIvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:51:14 -0500
Received: from [212.239.226.78] ([212.239.226.78]:38816 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S264330AbTKUItf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:49:35 -0500
From: Jan De Luyck <lkml@kcore.org>
To: jt@hpl.hp.com, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       "Mudama, Eric" <eric_mudama@maxtor.com>
Subject: Re: Announce: ndiswrapper
Date: Fri, 21 Nov 2003 08:58:24 +0100
User-Agent: KMail/1.5.4
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <785F348679A4D5119A0C009027DE33C105CDB514@mcoexc04.mlm.maxtor.com> <20031121000031.GA17869@bougret.hpl.hp.com>
In-Reply-To: <20031121000031.GA17869@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311210858.29082.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 21 November 2003 01:00, Jean Tourrilhes wrote:
> On Thu, Nov 20, 2003 at 04:53:12PM -0700, Mudama, Eric wrote:
> > I think the point being made is "Why spend an extra $150 on a PCMCIA wifi
> > card when there's an integrated wifi device already in the laptop that
> > ndiswrapper will allow to sortof work?"
> >
> > The person who bought this laptop and wants to run linux on it might not
> > have the extra money handy to use buying additional hardware.
> >
> > Not my point of view, but definitely "a" point of view.
> >
> > --eric
>
> 	My point is : why buy this laptop if it's not 100%
> supported ? They are plenty of other laptops...
> 	I can guarantee you that I'm more picky and more cheap than
> anyone when choosing laptops, and I always get something 100%
> supported.

I, too, am the owner of a 'centrino' laptop, which comes with the intel Pro/
wireless 2100 card. At the time I bought it, Intel said that they would be 
providing linux support for centrino, and since they made good on their 
claims in the past, I went ahead and bought it. Unfortunately, until now, 
they haven't substansiated that claim yet. And, I'm not really willing to 
cough up another 150-200 EUR for another minipci card, which - in some cases 
- - even has to be of a specific type to work with the bios of the system!

So, driverloader or ndiswrapper provides me with a workable solution, even 
though it's not really the way I like it. But it works. That's what counts 
for the majority of the 'desktop/laptop' linux users. They don't care how it 
happens, as long as it happens.

Personally I'm only half in that camp, since I like to use opensource & free 
drivers/software if available, and will advocate the use of such software. If 
no decent os substitutes are available, I'll use proprietary/binary only 
stuff nevertheless.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/vcWiUQQOfidJUwQRAp8dAJ9vxrt7K2nC9JkJgzGNw1ewsgrjNQCfTtMy
P8eS3BHEjw/eBxzKNLveVMk=
=/vnv
-----END PGP SIGNATURE-----

