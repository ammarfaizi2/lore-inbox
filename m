Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbUK0J7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUK0J7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 04:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbUK0J7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 04:59:38 -0500
Received: from node1.80686-net.de ([194.54.168.119]:58511 "EHLO
	mx1.80686-net.de") by vger.kernel.org with ESMTP id S261176AbUK0J7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 04:59:35 -0500
From: Manuel Schneider <root@80686-net.de>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Subject: Re: SD slot on IBM X40
Date: Sat, 27 Nov 2004 10:59:57 +0100
User-Agent: KMail/1.7
References: <Pine.LNX.4.61.0411271748130.22831@silk.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.61.0411271748130.22831@silk.corp.fedex.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4991561.Jx9Azj6vhr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411271100.02947.root@80686-net.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4991561.Jx9Azj6vhr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jeff,

I have also an SD- (and some other) card reader in my notebook.
These are working as standard usb-storage devices.
So you just do
# modprobe usb-storage
# mount /dev/sda1 /mnt/sd-card
(replace /dev/sda1 with your appropriate device and /mnt/sd-card with an=20
existing mountpoint).

Greets,

Manuel



Am Samstag, 27. November 2004 10:51 schrieben Sie:
> I've visited all the posting on linux laptop website and it seems that
> it's no possible to get the build-in SD slot to work under linux.
>
> It seems all the new notebooks are shipped with SD as standard (Toshiba,
> IBM at least), and I wonder whether anyone is working on this?
>
>
> Thanks,
> Jeff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
Manuel Schneider
root@80686-net.de
http://www.80686-net,de/

=2D----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCM d-- s:- a? C++$ UL++++ P+> L+++>$ E- W+++$ N+ o-- K- w--$ O+ M+ V
PS+ PE- Y+ PGP+ t 5 X R UF++++ !tv b+> DI D+ G+ e> h r y++=20
=2D-----END GEEK CODE BLOCK------

--nextPart4991561.Jx9Azj6vhr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqFAi+1L2Ft1n/K8RAsnKAJ0f/DSnWgjxkCrGtWZ6dFKgXjkI9ACdFKoh
GWCrn/EAirQaDubMHBbENbU=
=/cwb
-----END PGP SIGNATURE-----

--nextPart4991561.Jx9Azj6vhr--
