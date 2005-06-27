Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVF0Aks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVF0Aks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVF0Aks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:40:48 -0400
Received: from h80ad25fc.async.vt.edu ([128.173.37.252]:55430 "EHLO
	h80ad25fc.async.vt.edu") by vger.kernel.org with ESMTP
	id S261677AbVF0Ake (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:40:34 -0400
Message-Id: <200506270036.j5R0adSk030387@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Hans Reiser <reiser@namesys.com>, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sun, 26 Jun 2005 19:16:48 CDT."
             <42BF4570.9010405@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <42BF3D8F.4060503@namesys.com>
            <42BF4570.9010405@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119832598_3659P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Jun 2005 20:36:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119832598_3659P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Jun 2005 19:16:48 CDT, David Masover said:

> But, to avoid confusion, the inclusion of a crytocompress plugin in a
> given kernel doesn't mean that all files accessed from that kernel are
> encrypted and compressed.  It just means that you can pick an individual
> file and set it to be transparently encrypted/compressed.
> 
> That is what I meant by "enabled".  Not per-user, but per-file.

Doing key management in a secure manner is going to be *fun*. :)

--==_Exmh_1119832598_3659P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCv0oWcC3lWbTT17ARAqxRAJ9b8p/7BREnaMLwAGw+34B1n96+2QCg6V56
kgJ+9xEb6YW/qqUa6b3KRdA=
=l3W2
-----END PGP SIGNATURE-----

--==_Exmh_1119832598_3659P--
