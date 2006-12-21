Return-Path: <linux-kernel-owner+w=401wt.eu-S1423050AbWLUT21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423050AbWLUT21 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423053AbWLUT21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:28:27 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50378 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423050AbWLUT20 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:28:26 -0500
Message-Id: <200612211928.kBLJSPVS026906@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Marek Wawrzyczny <marekw1977@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
In-Reply-To: Your message of "Fri, 22 Dec 2006 02:34:54 +1100."
             <200612220234.55313.marekw1977@yahoo.com.au>
From: Valdis.Kletnieks@vt.edu
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com> <200612192357.45443.marekw1977@yahoo.com.au> <200612200511.kBK5BFo4019459@turing-police.cc.vt.edu>
            <200612220234.55313.marekw1977@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166729305_12674P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Dec 2006 14:28:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166729305_12674P
Content-Type: text/plain; charset=us-ascii

On Fri, 22 Dec 2006 02:34:54 +1100, Marek Wawrzyczny said:
>
> > And then there's stuff on this machine that are *not* options, but don't
> > matter to me.  I see an 'O2 Micro' Firewire in the 'lspci' output.  I have
> > no idea how well it works.  I don't care what it contributes to the score.
> > On the other hand, somebody who uses external Firewire disk enclosures may
> > be *very* concerned about it, but not care in the slightest about the
> > wireless card.
> 
> Perhaps we just report on the individual devices then... forget the system 
> rating.

OK, *that* I see as potentially useful - I frequently get handed older
boxen with strange gear in them, and need a way to figure out if I want to
install software, or cannibalize it for parts. Also helpful if a buddy has
a Frankintel box they build, and they want to know if they can install
something other than Windows.... 

Bonus points if it sees a card that has a known out-of-tree driver and
tells you where to find it and what its license status is (I just went
down that road with an Intel 3945)...

> > Bonus points for figuring out what to do with systems that have some chip
> > that's a supported XYZ driver, but wired up behind a squirrely bridge with
> > some totally bizarre IRQ allocation, so you end up with something that's
> > visible on lspci but not actually *usable* in any real sense of the term...
> 
> Hmmm... does this happen often? False results are definedly a show stopper.

Oh, we see reports of squirrelly or downright confused hardware all the time
on this list. :)

--==_Exmh_1166729305_12674P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFiuBZcC3lWbTT17ARAt0aAKCD3QufkQ9PMIX1gC3prFAVJbWuQQCg7mQm
VSBvtKglWVSUzhyvtoYZUhw=
=YfZZ
-----END PGP SIGNATURE-----

--==_Exmh_1166729305_12674P--
