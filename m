Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbTLFCja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 21:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLFCja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 21:39:30 -0500
Received: from h80ad271e.async.vt.edu ([128.173.39.30]:44690 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264936AbTLFCj1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 21:39:27 -0500
Message-Id: <200312060239.hB62dLps000513@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: partially encrypted filesystem 
In-Reply-To: Your message of "Fri, 05 Dec 2003 18:35:55 MST."
             <1070674555.2939.35.camel@patibmrh9> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0312060112450.11626-100000@gaia.cela.pl>
            <1070674555.2939.35.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_616546797P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Dec 2003 21:39:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_616546797P
Content-Type: text/plain; charset=us-ascii

On Fri, 05 Dec 2003 18:35:55 MST, Pat LaVarre said:

> Suppose we wish to encrypt the files on a disc or disk or drive that we
> carry from one computer to another.
> 
> Where else can the encryption go, if not "down to the file system"?

It could also be above the filesystem, a la PGP, or below the file system,
a la encrypted loopback.  Other options, such as steganography and "purloined
letter" schemes, are also at least theoretically possible, if not totally workable.

--==_Exmh_616546797P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/0UFZcC3lWbTT17ARAhZuAKCHmiCvisJ6ptwpe0gfwU35m97+TgCfQMug
FnAsp2Jx3QgAmDsseUgSDWY=
=oRsS
-----END PGP SIGNATURE-----

--==_Exmh_616546797P--
