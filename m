Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265951AbUFTVjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUFTVjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUFTVjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:39:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265951AbUFTVj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:39:28 -0400
Date: Sun, 20 Jun 2004 23:38:55 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 2/2] kbuild: Improved external module support
Message-ID: <20040620213854.GA5231@devserv.devel.redhat.com>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620212353.GD10189@mars.ravnborg.org> <1087766729.2805.15.camel@laptop.fenrus.com> <20040620214543.GA10332@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20040620214543.GA10332@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 20, 2004 at 11:45:43PM +0200, Sam Ravnborg wrote:
> 
> Did you put the output of the kernel compile in a separate output directory,
> reusing the same src for several configurations?

I do not ship the output of the kernel compile actually.
But I do not share the /lib/modules/version/build for different kernels,
it's unique.

> If not you do not need the change, and thus do not get any benefit. On the
> other hand everything should work as-is for you.


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA1gPuxULwo51rQBIRAhuHAJ9uGCTO7ul6KYErP2gbiMvzF/1i7QCeJjHm
grb374JBTF6rEsgl8T3zOIo=
=Zf9L
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
