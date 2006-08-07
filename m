Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWHGGI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWHGGI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHGGI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:08:27 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:7878 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751096AbWHGGI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:08:26 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Where does kernel/resource.c.1 file come from?
Date: Mon, 7 Aug 2006 08:11:20 +0200
User-Agent: KMail/1.9.4
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200607251554.50484.eike-kernel@sf-tec.de> <200607281603.38978.eike-kernel@sf-tec.de> <20060804130339.GA4014@ucw.cz>
In-Reply-To: <20060804130339.GA4014@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3285479.Kr4OSBDRPs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608070811.26612.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3285479.Kr4OSBDRPs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Pavel Machek wrote:
> Hi!
>
> > > > I'm playing around with my local copy of linux-2.6 git tree. I'm
> > > > building everything to a separate directory using O= to keep "git
> > > > status" silent.
> > > >
> > > > After building I sometimes find a file kernel/resource.c.1 in my git
> > > > tree that doesn't really belong there. Who is generating this file,
> > > > for what reason and why doesn't it get created in my output
> > > > directory?
> > >
> > > Can you also try to make sure that this file is generated as part of
> > > the build process. git status before and after should do it.
> >
> > I did a full rebuild and did not see the file again. Weird.
>
> Is not it emacs's (or other editor's?) numbered backup?

No.

Eike

--nextPart3285479.Kr4OSBDRPs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE1tmOXKSJPmm5/E4RApZXAKCY+2Li3HBHttJiYdHjZJ/RWhUKyACfa3n4
hHeQ8RWUDz55oIlKkW3s70Q=
=O4y+
-----END PGP SIGNATURE-----

--nextPart3285479.Kr4OSBDRPs--
