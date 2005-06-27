Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVF0GR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVF0GR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVF0GRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:17:55 -0400
Received: from h80ad25a1.async.vt.edu ([128.173.37.161]:20897 "EHLO
	h80ad25a1.async.vt.edu") by vger.kernel.org with ESMTP
	id S261883AbVF0GNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:13:43 -0400
Message-Id: <200506270612.j5R6CZGX008462@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Mon, 27 Jun 2005 00:57:54 CDT."
             <42BF9562.4090602@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu> <42BF8F42.7030308@slaphack.com> <200506270541.j5R5fULX007282@turing-police.cc.vt.edu>
            <42BF9562.4090602@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119852754_3633P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 02:12:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119852754_3633P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Jun 2005 00:57:54 CDT, David Masover said:

> In one of three possible settings for the imaginary zipfile plugin, yes.
>  But if we're talking about a kernel source tree, how many of us
> actually build zipfiles/tarballs of their kernel source trees, rather
> than unpack existing ones?

I dunno.  I'll often build a tarball of "-mm plus local patches" known to
be working at the moment, precisely so I can just untar that as a known good
base for the next kernel-hackfest, rather than untar Linus's tree, apply all
of the -mm patch, then all my local patches again...

And even if I'm not *that* ambitious, I'll at least tar up a clean -mm tree
to use as a base. :)

And even if I didn't do that, you *do* have to do something when the disk
gets backed up.  You *do* intend for sensible things to happen then, right? ;)


--==_Exmh_1119852754_3633P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCv5jRcC3lWbTT17ARAg/yAKDBvQXlCzhxYPZgDYelNnAXJeB72QCgtKvn
p8xX9mbO7Ejv/uBALr0xT88=
=Wbii
-----END PGP SIGNATURE-----

--==_Exmh_1119852754_3633P--
