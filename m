Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269862AbUJSRKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269862AbUJSRKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269874AbUJSRGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:06:24 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:43446 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S269857AbUJSRBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:01:21 -0400
Date: Tue, 19 Oct 2004 19:01:11 +0200
From: Martin Waitz <tali@admingilde.org>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041019170111.GG3618@admingilde.org>
Mail-Followup-To: Kendall Bennett <KendallB@scitechsoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <416FB29A.11731.1C46848@localhost> <4173BA7D.32320.11833A1D@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <4173BA7D.32320.11833A1D@localhost>
User-Agent: Mutt/1.3.28i
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Oct 18, 2004 at 12:43:41PM -0700, Kendall Bennett wrote:
> I am not sure what you mean by basic text output? If you mean to a=20
> display, then yes, embedded boxes using U-Boot and OpenBIOS usually do=20
> not have any text output. But if you mean serial output that is usually=
=20
> the method of choice for the embedded machines that don't have support=20
> for a physical display in the firmware.

I mean: text output on the preferred console.

Embedded devices have a serial console anyway and all other machines
have firmware support for drawing text.

That is: switching into graphics mode can be done by the firmware, bootload=
er,
or by userspace and doesn't have to be in the kernel.

--=20
Martin Waitz

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBdUhWj/Eaxd/oD7IRAkOeAJ98hh+cbbgohdQxYa6Gts/IxqwU0gCeKyNq
RnrxQCnBjqGjXt1Q58A8Ess=
=1+PR
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
