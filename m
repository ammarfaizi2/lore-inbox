Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269771AbUJAMh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269771AbUJAMh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269773AbUJAMh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:37:56 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:63192 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S269771AbUJAMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:37:42 -0400
Date: Fri, 1 Oct 2004 14:37:12 +0200
From: Martin Waitz <tali@admingilde.org>
To: Arvind Kalyan <arvy@cse.kongu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OS Virtualization
Message-ID: <20041001123712.GD4072@admingilde.org>
Mail-Followup-To: Arvind Kalyan <arvy@cse.kongu.edu>,
	linux-kernel@vger.kernel.org
References: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>
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


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Fri, Oct 01, 2004 at 04:47:06PM +0530, Arvind Kalyan wrote:
> My intentions are to give control to both the kernels to directly control
> the hardware and do "context switch" between those two based on
> time-slice.

Have a look at Xen: http://www.cl.cam.ac.uk/Research/SRG/netos/xen/
They don't really allow direct hardware manipulation but use drivers
of their own.

--=20
Martin Waitz

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBXU93j/Eaxd/oD7IRAtwGAJ9mIZx/spunpilIoomGnslnCKOppACfTTnX
d+Tl1q/FAT1BnaldwHFmIk0=
=RqUW
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
