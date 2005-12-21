Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVLUWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVLUWQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVLUWQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:16:42 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:4580 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S964829AbVLUWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:16:42 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] TOMOYO Linux released!
Date: Wed, 21 Dec 2005 23:16:34 +0100
User-Agent: KMail/1.7.2
References: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp> <1135164793.3456.9.camel@laptopd505.fenrus.org>
In-Reply-To: <1135164793.3456.9.camel@laptopd505.fenrus.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1246322.YTt4Z7P11O";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512212316.39164.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1246322.YTt4Z7P11O
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Arjan,

On Wednesday 21 December 2005 12:33, you wrote:
>    per user /tmp is a very attractive feature and all needed
>    infrastructure helpers for this will be in the 2.6.15 kernel)

Yes! I use this (via symlinks) already and love it.

If I now could get age based file removal, to free up more
temporary space for sth. else with limits on minimum age,
I would be a very happy user.

I know this could be done in user space similiar to
the dynamic swap space addition.

So just take this as a hint from a customer :-)


Regards

Ingo Oeser


--nextPart1246322.YTt4Z7P11O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDqdRHU56oYWuOrkARAr7OAKCO1Vgnx5Oo/QQwJ/lE9l2R/t/CugCfbCVP
aGosQk0qiJ1g77qFeYAQJhk=
=HNpG
-----END PGP SIGNATURE-----

--nextPart1246322.YTt4Z7P11O--
