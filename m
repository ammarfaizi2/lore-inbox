Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbTCOTHc>; Sat, 15 Mar 2003 14:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbTCOTHc>; Sat, 15 Mar 2003 14:07:32 -0500
Received: from kknd.mweb.co.za ([196.2.45.79]:44268 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id <S261522AbTCOTHa>;
	Sat, 15 Mar 2003 14:07:30 -0500
Date: Sat, 15 Mar 2003 21:11:51 +0200
From: Martin Schlemmer <azarah@gentoo.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <mitch@theneteffect.com>, <davej@codemonkey.org.uk>,
       <Randy.Dunlap@mako.theneteffect.com>, <randy.dunlap@verizon.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] update filesystems config. menu
Message-Id: <20030315211151.40f1cf84.azarah@gentoo.org>
In-Reply-To: <33707.4.64.238.61.1047748124.squirrel@www.osdl.org>
References: <200303150920.h2F9KGm16328@mako.theneteffect.com>
	<1047720287.3505.146.camel@workshop.saharact.lan>
	<33707.4.64.238.61.1047748124.squirrel@www.osdl.org>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.5(ie,dGDZ+wCAj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.5(ie,dGDZ+wCAj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Mar 2003 09:08:44 -0800 (PST)
"Randy.Dunlap" <rddunlap@osdl.org> wrote:


> I'm having trouble decoding...
> What is it that "should be safest for most people"?
> Are you suggesting any changes here?
> 
> And some of us don't use fs modules, just build what we need into the
> kernel.  Do you know of any problems with doing this (related to
> ext2/ext3 for example)?
> 

I was just saying that recommending it (ext2) compiled into the kernel
and not a module should be the safe route for newbies to kernel
compiles.

Those of us that have build a few to feel comfortable with it, will know
to compile the fs of our / partition into the kernel.

Except if ext2 is not the most commonly used fs anymore.  I guess a
'cool' feature could be if the make system could 'detect' what your
current root is and warn if you do not have that compiled into your
kernel, but I do not know the limitations of it (the make system).

Then on the other hand, would above be confusing if its a kernel
compiled for another box ?


Regards,

-- 

Martin Schlemmer


--=.5(ie,dGDZ+wCAj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+c3r+qburzKaJYLYRAg+cAKCRnnPh06MXzzlJR95qRy8WEnwGdwCePR0n
Tzpr9j7196N9DHAbn8YryMM=
=ESxj
-----END PGP SIGNATURE-----

--=.5(ie,dGDZ+wCAj--
