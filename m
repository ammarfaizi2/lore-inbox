Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933374AbWFZWvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933374AbWFZWvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933332AbWFZWvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:51:09 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45486 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S933374AbWFZWut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:50:49 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][ 0/7] Proc file support
Date: Tue, 27 Jun 2006 08:50:44 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net> <200606262207.38006.rjw@sisk.pl>
In-Reply-To: <200606262207.38006.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1296521.bfE0CBeKdT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606270850.47419.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1296521.bfE0CBeKdT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 06:07, Rafael J. Wysocki wrote:
> On Monday 26 June 2006 18:47, Nigel Cunningham wrote:
> > Generic routines for implementing the /proc/suspend2 files that allow
> > the user to configure and tune the subsystem according to their needs.
>
> All of the following patches seem to modify the same file:
> kernel/power/proc.c I'd prefer if these changes were all done in one patc=
h.
>
> Rafael

I've done this with all the new files, so that each part of the file can be=
=20
considered without suffering from overload.

Regards,

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1296521.bfE0CBeKdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoGTHN0y+n1M3mo0RAurbAJ9a1zjoVe7a08hFVeK7XdhpUu04WACgtRWc
1jJ0CShrghVfJzxCFjwiUkI=
=nWPf
-----END PGP SIGNATURE-----

--nextPart1296521.bfE0CBeKdT--
