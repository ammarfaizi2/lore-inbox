Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWG1OBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWG1OBa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWG1OB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:01:29 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:56448 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1161159AbWG1OB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:01:29 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Where does kernel/resource.c.1 file come from?
Date: Fri, 28 Jul 2006 16:03:38 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607251554.50484.eike-kernel@sf-tec.de> <20060725151520.GA15681@mars.ravnborg.org>
In-Reply-To: <20060725151520.GA15681@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1881937.GiZ8PCy4V6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607281603.38978.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1881937.GiZ8PCy4V6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 25. Juli 2006 17:15 schrieb Sam Ravnborg:
> On Tue, Jul 25, 2006 at 03:54:45PM +0200, Rolf Eike Beer wrote:
> > Hi,
> >
> > I'm playing around with my local copy of linux-2.6 git tree. I'm building
> > everything to a separate directory using O= to keep "git status" silent.
> >
> > After building I sometimes find a file kernel/resource.c.1 in my git tree
> > that doesn't really belong there. Who is generating this file, for what
> > reason and why doesn't it get created in my output directory?
>
> Can you also try to make sure that this file is generated as part of the
> build process. git status before and after should do it.

I did a full rebuild and did not see the file again. Weird.

Eike

--nextPart1881937.GiZ8PCy4V6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEyhk6XKSJPmm5/E4RAqhVAKCjgQ8KFc0dQxpdIGhpaCJQDn2z7ACfa0Ip
1AmbG8OwkrvZLtj4gzhuCts=
=YpTD
-----END PGP SIGNATURE-----

--nextPart1881937.GiZ8PCy4V6--
