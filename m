Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314075AbSDZQMj>; Fri, 26 Apr 2002 12:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSDZQMi>; Fri, 26 Apr 2002 12:12:38 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:40019 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314075AbSDZQMi>;
	Fri, 26 Apr 2002 12:12:38 -0400
Date: Fri, 26 Apr 2002 18:10:49 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 IDE 42
Message-Id: <20020426181049.5eb31b05.sebastian.droege@gmx.de>
In-Reply-To: <3CC904AA.7020706@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.)k_ieUGD++5Pgj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.)k_ieUGD++5Pgj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2002 09:41:30 +0200
Martin Dalecki <dalecki@evision-ventures.com> wrote:

Hi,

@@ -584,27 +585,25 @@
 			drive->failures = 0;
 		} else {
 			drive->failures++;
+			char *msg = "";

My compiler won't compile that ;)
Declare msg after the function's beginning and it compiles fine

Bye
--=.)k_ieUGD++5Pgj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8yXwae9FFpVVDScsRAvhmAKDLU9mQ17uC1utuvOefpSZY4SHmbgCgrCd+
nNw24fDxrduopJOMawKtkmI=
=mRMX
-----END PGP SIGNATURE-----

--=.)k_ieUGD++5Pgj--

