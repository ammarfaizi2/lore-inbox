Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVF0QwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVF0QwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVF0Qsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:48:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:31616 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261399AbVF0Qlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 12:41:37 -0400
Message-Id: <200506271640.j5RGefRQ018912@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Mon, 27 Jun 2005 02:00:49 CDT."
             <42BFA421.70506@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu> <42BF8F42.7030308@slaphack.com> <200506270541.j5R5fULX007282@turing-police.cc.vt.edu> <42BF9562.4090602@slaphack.com> <200506270612.j5R6CZGX008462@turing-police.cc.vt.edu> <42BF9C4D.3080800@slaphack.com> <200506270643.j5R6hqRh009781@turing-police.cc.vt.edu>
            <42BFA421.70506@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119890441_6336P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 12:40:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119890441_6336P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Jun 2005 02:00:49 CDT, David Masover said:

> >>Speaking of backup, that's another nice place for a plugin.  Imagine a
> >>dump that didn't have to be of the entire FS, but rather an arbitrary
> >>tree...  That might be a nice new archive format.  I know Apple already
> >>uses something like this for their dmg packages.
> > Hmm.. you mean like 'tar' or 'cpio' or 'pax' or 'rsync'? :) 
> No, a dmg is an OS X program installer.  It appears to be a disk image
> of sorts.  So this is the backup idea in reverse.

I was addressing the ability to deal with an arbitrary tree.  By that definition,
a dmg, being a disk image and not a tree image, is *not* what you want....

--==_Exmh_1119890441_6336P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwCwJcC3lWbTT17ARAgRvAJ97aLQPxXPmwyRxzjRtplO4qZRmfwCgoEeJ
begE6L5YF0RAgkWi9u4DXoY=
=PlVl
-----END PGP SIGNATURE-----

--==_Exmh_1119890441_6336P--
