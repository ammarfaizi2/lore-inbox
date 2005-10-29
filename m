Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVJ2PkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVJ2PkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 11:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJ2PkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 11:40:14 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:26329 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751204AbVJ2PkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 11:40:13 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Date: Sat, 29 Oct 2005 17:40:01 +0200
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
       vojtech@suse.cz, akpm@osdl.org
References: <200510271026.10913.ak@suse.de> <20051028205916.GL4464@flint.arm.linux.org.uk> <20051028212305.GA2447@elf.ucw.cz>
In-Reply-To: <20051028212305.GA2447@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1786996.uI0HkzAEuM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510291740.11099.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1786996.uI0HkzAEuM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 28 October 2005 23:23, Pavel Machek wrote:
> I do notice lost keys on x32 here. You need to press some weird
> combination...

So just tell the message, if !strcmp(current->comm,'emacs') :-)

Regards

Ingo Oeser


--nextPart1786996.uI0HkzAEuM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDY5fbU56oYWuOrkARAnLeAJ9IIGmwbj1QfnotRyiJbbPJehaSQACglP/w
0gam20RX9TJWoGVRn9cVHZY=
=7bV6
-----END PGP SIGNATURE-----

--nextPart1786996.uI0HkzAEuM--
