Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWDUV7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWDUV7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWDUV7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:59:53 -0400
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:53385 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751364AbWDUV7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:59:52 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Updated version of shrink_all_memory tweaks.
Date: Sat, 22 Apr 2006 07:58:26 +1000
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200604212039.19676.ncunningham@cyclades.com> <200604212355.57447.rjw@sisk.pl>
In-Reply-To: <200604212355.57447.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1743844.yxhAApnTYb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604220758.33526.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1743844.yxhAApnTYb
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 22 April 2006 07:55, Rafael J. Wysocki wrote:
> Hi,
>
> On Friday 21 April 2006 12:39, Nigel Cunningham wrote:
> > I give the shrink_all_memory tweaks a try today, and fixed a couple of
> > mistakes that meant too much memory was still freed. With this version =
of
> > the patch, you get at most exactly what you ask for.
>
> Thanks for testing and fixes.
>
> Could you please make a patch on top of the
> swsusp-rework-memory-shrinker-rev-2.patch
> that went to -mm?  [Attached for convenience.]

Ok and thanks. By the way, I've incorporated it in the latest Suspend2=20
release, so it should see wider testing in the next couple of days.

Regards,

Nigel

--nextPart1743844.yxhAApnTYb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBESVWJN0y+n1M3mo0RAnrXAJ9ff6bfv9ozgMRPrz45G1SlHNkOUACfXt3Z
tkfTOjCOeGGFr0xZrIugyqE=
=cfds
-----END PGP SIGNATURE-----

--nextPart1743844.yxhAApnTYb--
