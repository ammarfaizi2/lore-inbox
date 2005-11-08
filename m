Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbVKHXFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbVKHXFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVKHXFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:05:36 -0500
Received: from admingilde.org ([213.95.32.146]:5027 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1030392AbVKHXFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:05:35 -0500
Date: Wed, 9 Nov 2005 00:05:31 +0100
From: Martin Waitz <tali@admingilde.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] kernel-doc: nested structs and unions support
Message-ID: <20051108230531.GO9633@admingilde.org>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20051108193810.GB14202@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lBqJz4CGKwlWe7/k"
Content-Disposition: inline
In-Reply-To: <20051108193810.GB14202@mipter.zuzino.mipt.ru>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lBqJz4CGKwlWe7/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Nov 08, 2005 at 10:38:10PM +0300, Alexey Dobriyan wrote:
> Sam, do you like the syntax? I hope properly indented rendering will
> appear soon.

Syntax and patch for nested structs looks good.

But are there many nested structs that will be documented that way?
Or is it better to focus on cross references so that we can simply
add documentation for both the inner and outer structure, and add
hyperlinks from the outer to the inner structure?

--=20
Martin Waitz

--lBqJz4CGKwlWe7/k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcS87j/Eaxd/oD7IRAleoAJ9gEJobNeoDneqMV3Mxcl/NdYWTAwCfeT52
au7ztXrluL72j42elAUqDgI=
=ycC+
-----END PGP SIGNATURE-----

--lBqJz4CGKwlWe7/k--
