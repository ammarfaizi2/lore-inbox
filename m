Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVJEUWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVJEUWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVJEUWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:22:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45034 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030366AbVJEUWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:22:02 -0400
Message-Id: <200510052021.j95KLegA024532@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Marc Perkel <marc@perkel.com>
Cc: Florin Malita <fmalita@gmail.com>, lsorense@csclub.uwaterloo.ca,
       nix@esperi.org.uk, 7eggert@gmx.de, lkcl@lkcl.net,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Wed, 05 Oct 2005 12:44:25 PDT."
             <43442D19.4050005@perkel.com> 
From: Valdis.Kletnieks@vt.edu
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com>
            <43442D19.4050005@perkel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128543700_3015P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Oct 2005 16:21:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128543700_3015P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Oct 2005 12:44:25 PDT, Marc Perkel said:
> What you don't get is that if you don't have rights to write to a file 
> then you shouldn't have the right to delete the file.  Once you get past 
> the "inside the box" Unix thinking you'll see the logic in this. So what 
> if the process of deleting a file involves writing to it. That's not 
> relevant.

Oddly enough, killfiles are *also* based on the concept of removing something
without the need or ability to look at the contents....

*plonk*

(Real-world analogy - if you've *ever* thrown away a box of anything without
opening the box, you understand that you don't need to be able to modify the
box to discard it.  The space enclosed by your domicile is basically read/write,
the box can be read-only and still end up in the dumpster.  On the other hand,
discarding the back staircase is a lot harder, as the frame of the house is
basically read-only, and you need to make it read-write in order to remove the
attachment points of the staircase.  Any Joe Sixpack carpenter understands this
to be entirely intuitive...)

--==_Exmh_1128543700_3015P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDRDXUcC3lWbTT17ARAq9EAKDoUqviXtn1PBgTnFO6EfMdx6hsRACfT/0F
TcYHIhGHxxlRBx/dwqlW2QE=
=8396
-----END PGP SIGNATURE-----

--==_Exmh_1128543700_3015P--
