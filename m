Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129544AbQKHB3x>; Tue, 7 Nov 2000 20:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQKHB3o>; Tue, 7 Nov 2000 20:29:44 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:25411 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130027AbQKHB3d>; Tue, 7 Nov 2000 20:29:33 -0500
Date: Tue, 7 Nov 2000 23:58:00 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Igmar Palsenberg <maillist@chello.nl>
Cc: RAJESH BALAN <atmproj@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: malloc(1/0) ??
Message-ID: <20001107235800.R17245@redhat.com>
In-Reply-To: <20001107035905.18154.qmail@web3707.mail.yahoo.com> <Pine.LNX.4.21.0011080140300.32613-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="f4HxWLVbzokH9yio"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011080140300.32613-100000@server.serve.me.nl>; from maillist@chello.nl on Wed, Nov 08, 2000 at 01:41:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f4HxWLVbzokH9yio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2000 at 01:41:40AM +0100, Igmar Palsenberg wrote:

> malloc(0) is bogus in this case. malloc(0) == free();

No, you're thinking of realloc.

Tim.
*/

--f4HxWLVbzokH9yio
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6CJcHONXnILZ4yVIRAvfTAJ9GPpX0RMpOeTUhF3r49or515PC/QCdFg3N
G5LTt2i5TIcSaRf/RK2rWLs=
=e2wv
-----END PGP SIGNATURE-----

--f4HxWLVbzokH9yio--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
