Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUJZE0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUJZE0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUJZBis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:38:48 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47576 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262094AbUJZBXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:54 -0400
Date: Tue, 26 Oct 2004 00:52:06 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Lars Roland <lroland@gmail.com>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041025225206.GA30574@thundrix.ch>
References: <4176E08B.2050706@techsource.com> <4ad99e05041025093856cd16ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <4ad99e05041025093856cd16ba@mail.gmail.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Mon, Oct 25, 2004 at 06:38:48PM +0200, Lars Roland wrote:
> As I said, it should have enough 3D features to be used together with
> xorg both now and in the future - so you should look hard at what
> Longhorn /Mac OS X have done and decide what features to implement. I
> do not care if it can run doom3 or not, I have yet to come across a
> graphic card that can run the latest games and have decent Linux
> support (this is especially true when you are running dual head).

You don't want  good Longhorn support, as currently  at least Longhorn
still uses  the proprietary GDI 2D drawing  algorithms, and DirectDraw
in rare cases.  MacOS/X does  the drawing and effects in OpenGL, which
is what  you want.  As  will X.Org.  So  you want OpenGL  support, and
you'll be done. (Once framebuffers  are being drawn in OpenGL as well,
which isn't impossible to happen.)

Maybe we'll need a graphics card that does OpenGL *only*...

			    Tonnerre

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBfYOV/4bL7ovhw40RAmVAAJwKhgllgInS9HKB87h7lJ7zw/IUJgCcCZCX
AGF8npxRd3zH0YADd/VecwY=
=Qief
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
