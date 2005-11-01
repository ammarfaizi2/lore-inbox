Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVKAKeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKAKeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 05:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVKAKeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 05:34:06 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:11718 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1750729AbVKAKeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 05:34:05 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Tue, 1 Nov 2005 21:33:59 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Message-ID: <20051101103358.GA28394@cse.unsw.EDU.AU>
References: <20051101020329.GA7773@cse.unsw.EDU.AU> <200511010055.32726.dtor_core@ameritech.net> <20051101060443.GF11202@cse.unsw.EDU.AU> <200511010114.38632.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <200511010114.38632.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 01, 2005 at 01:14:38AM -0500, Dmitry Torokhov wrote:
> Have you tried it by any chance? I'd feel much better pushing it upstream
> knowing that it was tested at least once...

Yes, works fine on my iBook, thanks.

Does anyone know what the eqivalent of 'cvs update -C file' is with
git?  It is a common use-case for me to make a few changes, send off a
diff and then get another one back which I want to apply to the
orignal.

-i

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDZ0SWWDlSU/gp6ecRAhp5AKCa80LeHu0vvPdILu+h6Z01RtqFqACgp54t
e1X6k8ILO/FEZwh6SHpxr9c=
=2JbA
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
