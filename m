Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVBQHzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVBQHzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 02:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBQHzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 02:55:50 -0500
Received: from hamlet.e18.physik.tu-muenchen.de ([129.187.154.223]:62932 "EHLO
	hamlet.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262252AbVBQHze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 02:55:34 -0500
In-Reply-To: <4213E141.5040407@tequila.co.jp>
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com> <7579f7fb0502141017f5738d1@mail.gmail.com> <20050214185624.GA16029@bitmover.com> <1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp> <20050216154321.GB34621@dspnet.fr.eu.org> <4213E141.5040407@tequila.co.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-35--676774539"
Message-Id: <e9d587a22ff0b23ccbb6fa112377dbee@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
Cc: Olivier Galibert <galibert@pobox.com>, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: [BK] upgrade will be needed
Date: Thu, 17 Feb 2005 08:55:27 +0100
To: Clemens Schwaighofer <cs@tequila.co.jp>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-35--676774539
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Clemens!

On Feb 17, 2005, at 1:11 AM, Clemens Schwaighofer wrote:

> first. what kind of advantages does bk have over other svn? Seriously.
> If Apache can use it, and gcc might use it (again two very large
> projects), what makes linux so differetnt that it can't.
>
> And I don't want _anything_ from Larry. I am just pointing out, that
> this kind of legal clause is more ridicolous than understandable.
>
Well, I'm obviously not Larry, so here are my 2ct:

Subversion is superior to CVS in all respects, but that is not an 
overly strong statement. The main problem is that it is centralized in 
a way that hinders the parallel existence of development branches 
because it does not properly support the shuffling of changes back and 
forth between trees. It all works fine until you want to _partially_ 
synchronize two trees and keep the ability to continue development on 
both of them. (Been there, done that, it was a major PITA even in a 
rather small project. Works fine for my PhD thesis, though ;-) )

That said, it would of course be possible to improve the internal 
workflow of our emperor penguin if he used subversion, but the 
collaboration with others could not benefit the way it does with a 
changeset-based approach.

> Last, why can you compare cvs to bk? and not subversion, or arch? arch
> and subversion are way superiour to cvs ...
>
>> SCM is hard and not sexy, I'm afraid.
>
> yes its hard, so we have to use bk with a very strange license?
> better close the eyes and not change. What do you think is kernel
> coding? Walk in the park? Do you think all those developers say, nah I
> better use Windows or Mac OS X, because its hard and not sexy ... pah
> ... BS!
>
Linux kernel development is hard _and_ sexy :-)

Ciao,
					Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str. 85747 Garching
Telefon 089/289-12592; Telefax 089/289-12570
--
A mouse is a device used to point at
the xterm you want to type in.
Kim Alm on a.s.r.

--Apple-Mail-35--676774539
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD4DBQFCFE30I4MWO8QIRP0RAhHCAJdB5wtQ+s7x1FjwkGazmGG4NZ4UAJ91iC7o
c19AjTY4rZ0ODTL98ipo0A==
=h6vu
-----END PGP SIGNATURE-----

--Apple-Mail-35--676774539--

