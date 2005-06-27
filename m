Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVF0Eaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVF0Eaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVF0Eaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:30:35 -0400
Received: from h80ad25a1.async.vt.edu ([128.173.37.161]:33468 "EHLO
	h80ad25a1.async.vt.edu") by vger.kernel.org with ESMTP
	id S261802AbVF0E3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:29:37 -0400
Message-Id: <200506270427.j5R4RYiO004629@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sun, 26 Jun 2005 21:37:48 CDT."
             <42BF667C.50606@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
            <42BF667C.50606@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119846453_3633P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 00:27:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119846453_3633P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Jun 2005 21:37:48 CDT, David Masover said:

> > Go read http://www.tux.org/lkml/#s7-7 and ponder until enlightenment arrives.
> 
> So what?  I don't intend to convince anyone based on how much
> slower/faster their kernel compiles.  It's meant to illustrate the
> principle of the thing.

No, you seemed convinced that you'd have a big win based on the fact that
big chunks don't get unpacked - when in fact it's not as much of a win as
you might think.

And at least in the real world, performance *does* matter - if doing it the
traditional way is 3 times faster, nobody's going to be interested.

> Besides, your point was that you could not run make inside of a kernel
> tarball/zipfile.  Nobody ever suggested that you would actually want to.

"Here's a new facility.  Don't bother trying to actually use it".

Is that the message you're trying to send?

--==_Exmh_1119846453_3633P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCv4A1cC3lWbTT17ARAtNKAJwOVk6iv2fFy7RVoXOk8TM8oJugKACfTjzP
Z0WZccghT2ed/wVS8X5lRjw=
=N43F
-----END PGP SIGNATURE-----

--==_Exmh_1119846453_3633P--
