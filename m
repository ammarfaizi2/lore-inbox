Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUDCTyo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUDCTyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:54:44 -0500
Received: from ns.suse.de ([195.135.220.2]:19145 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261914AbUDCTym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:54:42 -0500
Date: Sat, 3 Apr 2004 21:54:40 +0200
From: Kurt Garloff <garloff@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer adjustments
Message-ID: <20040403195440.GB3169@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040403000447.GU3328@tpkurt.garloff.de> <Pine.LNX.4.44.0404031311400.30015-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404031311400.30015-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.4-46.1-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rik,

On Sat, Apr 03, 2004 at 01:12:07PM -0500, Rik van Riel wrote:
> Shouldn't such an adjustment be inherited at fork time,
> if we decide we want it in the kernel ?

It is inherited. Why do you think it's not?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAbxaAxmLh6hyYd04RAs0qAJwLHeVJJFv8wO8e49zKDKjxcYjTJgCdFg01
EmIU+6djaiJgZ/M7MY692lI=
=9eDP
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
