Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTHZQ1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTHZQ1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:27:10 -0400
Received: from h80ad2714.async.vt.edu ([128.173.39.20]:37763 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262577AbTHZQ1F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:27:05 -0400
Message-Id: <200308261626.h7QGQmMe020818@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: authentication / encryption key retention 
In-Reply-To: Your message of "Tue, 26 Aug 2003 17:07:03 BST."
             <12962.1061914023@redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <1061911851.20946.47.camel@dhcp23.swansea.linux.org.uk> <Pine.LNX.4.44.0308221044470.20736-100000@home.osdl.org> <11490.1061892774@redhat.com>
            <12962.1061914023@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1645581010P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Aug 2003 12:26:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1645581010P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Aug 2003 17:07:03 BST, David Howells said:
> > <Alan Cox said, full attribution lost>
> > > On Maw, 2003-08-26 at 11:12, David Howells wrote:
>  > > I think for the moment, however, we can assume there will be a single key.
> > How is the key choice different to say selinux roles ?
> 
> I'm not sure. After a quick overview of SE Linux, it doesn't seem that it
> would be able to support this.

Well, selinux *does* support the concept of a "role" - Alan's question was
whether it's safe to assume that  "a single key" is a safe assumption, or
if it's reasonable to have multiple keys.

--==_Exmh_1645581010P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/S4pHcC3lWbTT17ARAmXOAKDBtmDecvGhCFSOkcNfCPQHoALV6gCg7/jB
Ak4jvbL5cNnnLfHtWA3RbHc=
=Bzm0
-----END PGP SIGNATURE-----

--==_Exmh_1645581010P--
