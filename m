Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTLCJDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 04:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTLCJCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 04:02:47 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:9939 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S264526AbTLCIuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 03:50:54 -0500
Date: Wed, 3 Dec 2003 09:50:00 +0100
From: Martin Waitz <tali@admingilde.org>
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix use-after-free in sbp2.c
Message-ID: <20031203085000.GC1117@admingilde.org>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20031201210212.GA2184@admingilde.org> <20031202233125.GP19051@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20031202233125.GP19051@phunnypharm.org>
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Tue, Dec 02, 2003 at 06:31:25PM -0500, Ben Collins wrote:
> Could you test what's in our repo first?
will do next time ;)

> We've already fixed this, but it was done in a way different way than
> you did (we got rid of the semaphore).
well thats even better

your code is much cleaner,
i just wanted to make it work with minimal changes as
i didn't knew it was already fixed.

thanks for the great 1394 work! :)

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/zaO3j/Eaxd/oD7IRAhmNAJ0WYny1SiJl/Vo+lhMxObChrF+PJACfZeTU
4qJDkLXkT8YRnKGTQKOLCds=
=meSe
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
