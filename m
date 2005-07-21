Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVGUMSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVGUMSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 08:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVGUMSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 08:18:39 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:10939 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261767AbVGUMSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 08:18:38 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove unneeded indentation in drivers/char/watchdog/i8xx_tco.c
Date: Thu, 21 Jul 2005 14:19:50 +0200
User-Agent: KMail/1.8.1
References: <200507201036.20165@bilbo.math.uni-mannheim.de> <42DF8C7B.6090905@kernelconcepts.de>
In-Reply-To: <42DF8C7B.6090905@kernelconcepts.de>
Cc: Nils Faerber <nils.faerber@kernelconcepts.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1908108.rjyJr4n2Lx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507211419.56125@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1908108.rjyJr4n2Lx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Nils Faerber wrote:
>Rolf Eike Beer schrieb:

>> this patch changes a bit of indentation. Currently it is
>> [...]
>> Also some superfluous spaces are killed to match Codingstyle
>
>Don't know who added those strange things ;)
>But looks OK to me to change it this way.
>
>So please go ahead and forward this patch.

In this case add a Signed-off-by.

Eike

--nextPart1908108.rjyJr4n2Lx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC35LsXKSJPmm5/E4RAgQtAKCHumCOHzIkLmfv7phP2wuleDe65QCdEYkO
dtw8rQTHU5Tfeqwe4dLJP8E=
=PO1E
-----END PGP SIGNATURE-----

--nextPart1908108.rjyJr4n2Lx--
