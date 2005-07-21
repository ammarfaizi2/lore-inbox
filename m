Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVGUQW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVGUQW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 12:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVGUQW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 12:22:26 -0400
Received: from smtp3.pp.htv.fi ([213.243.153.36]:36269 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261795AbVGUQWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 12:22:25 -0400
Date: Thu, 21 Jul 2005 19:22:23 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Jiri Slaby <lnx4us@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete files in 2.6 tree
Message-ID: <20050721162223.GA12239@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jiri Slaby <lnx4us@gmail.com>, Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42DED9F3.4040300@gmail.com> <42DF6F34.4080804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <42DF6F34.4080804@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2005 at 11:47:32AM +0200, Jiri Slaby wrote:
> drivers/char/scan_keyb.c
> drivers/char/scan_keyb.h

These still work, but are meant to be used by other drivers and not
standalone. There's a few users of this that haven't been merged yet
anyways.

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC38u/1K+teJFxZ9wRAtUSAJ9xMNvKpqA1bLB4GLgGPHL8rx5mqQCeLePr
cr2Gsv1P+SiZ9QMwIUZ0IO0=
=MJXz
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
