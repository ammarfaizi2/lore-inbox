Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVJCQcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVJCQcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVJCQcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:32:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:42114 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751169AbVJCQcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:32:54 -0400
Message-Id: <200510031632.j93GWZbY012554@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Sun, 02 Oct 2005 22:12:38 EDT."
             <200510030212.j932CcKT025910@laptop11.inf.utfsm.cl> 
From: Valdis.Kletnieks@vt.edu
References: <200510030212.j932CcKT025910@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128357155_5142P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 12:32:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128357155_5142P
Content-Type: text/plain; charset=us-ascii

On Sun, 02 Oct 2005 22:12:38 EDT, Horst von Brand said:

> >                                                                     some
> >  operating system primitives, such as message passing (based on a
> >  derivative by thompson of the "alice" project from plessey, imperial and
> >  manchester university in the mid-80s), hardware cache line lookups
> >  (which means instead of linked list searching, the hardware does it for
> >  you in a single cycle), stuff like that.
> 
> Single CPU cycle for searching data in memory? Impossible.

Well... if it was content-addressable RAM similar to what's already used for
the hardware TLB's and the like - just that it's one thing to make a 32 or 256
location content-addressable RAM, and totally another to have multiple megabytes
of the stuff. :)

--==_Exmh_1128357155_5142P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQV0jcC3lWbTT17ARAi/hAJ42LiUjctftfIjUUD+cfCOBK9002ACg7Bra
1gXBy94CqkQLDTb5ggOALgg=
=+azY
-----END PGP SIGNATURE-----

--==_Exmh_1128357155_5142P--
