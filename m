Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUJKOaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUJKOaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUJKOaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:30:02 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:44686 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S269017AbUJKO0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:26:04 -0400
Date: Mon, 11 Oct 2004 16:23:29 +0200
From: Martin Waitz <tali@admingilde.org>
To: Steve Dickson <SteveD@redhat.com>
Cc: Clemens Schwaighofer <cs@tequila.co.jp>, nfs@lists.sourceforge.net,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS using CacheFS
Message-ID: <20041011142329.GJ4072@admingilde.org>
Mail-Followup-To: Steve Dickson <SteveD@redhat.com>,
	Clemens Schwaighofer <cs@tequila.co.jp>, nfs@lists.sourceforge.net,
	Linux filesystem caching discussion list <linux-cachefs@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4161B664.70109@RedHat.com> <41661950.5070508@tequila.co.jp> <41667865.2000804@RedHat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline
In-Reply-To: <41667865.2000804@RedHat.com>
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


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Fri, Oct 08, 2004 at 07:22:13AM -0400, Steve Dickson wrote:
> The 'fscache' flag will be coming along with the nfs4 support, since
> nfs4 mounting code does not have an open (unused) mounting flag....

is such a flag even neccessary?
The way I see fscache is that its operations will be no-ops anyway if you
haven't mounted any backing cache.

--=20
Martin Waitz

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBapdgj/Eaxd/oD7IRAmPmAJ9b2l9TuQSokw+O55kM+aqUutb0OQCdGkxe
nyV9WhgMUTRRWeEbOfwoQuo=
=wQV1
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--
