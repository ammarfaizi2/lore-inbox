Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVCWH2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVCWH2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVCWH2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:28:03 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:62674 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262844AbVCWH17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:27:59 -0500
Date: Wed, 23 Mar 2005 08:27:50 +0100
From: Martin Waitz <tali@admingilde.org>
To: "shafa.hidee" <shafa.hidee@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redirecting output
Message-ID: <20050323072750.GT8617@admingilde.org>
Mail-Followup-To: "shafa.hidee" <shafa.hidee@gmail.com>,
	linux-kernel@vger.kernel.org
References: <001e01c52f74$2f27daa0$6a88cb0a@hss.hns.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ggMi11T3lbLnZZ+m"
Content-Disposition: inline
In-Reply-To: <001e01c52f74$2f27daa0$6a88cb0a@hss.hns.com>
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
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ggMi11T3lbLnZZ+m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Mar 23, 2005 at 12:12:02PM +0530, shafa.hidee wrote:
>      I have created a dummy module for learning device driver in linux. I
> want to redirect the standard output of printk to my xterm. But by default
> it is redirected to tty.

The kernel does not have 'standard output', so you can't redirect it.
Please consult the manual for dmesg and syslog.

And please have a look at a good Linux kernel book.
This will help you understand the kernel and will answer most
of your questions.

--=20
Martin Waitz

--ggMi11T3lbLnZZ+m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCQRp1j/Eaxd/oD7IRAlIcAJ9fnJHJA+i5wvTbTwXC3tSW4lrpZQCcDuVh
BEyXlth83sSpYm8LFIz4irc=
=NQTV
-----END PGP SIGNATURE-----

--ggMi11T3lbLnZZ+m--
