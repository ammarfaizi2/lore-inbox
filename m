Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWCUFRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWCUFRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWCUFRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:17:19 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:27110 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030316AbWCUFRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:17:18 -0500
Message-ID: <441F8C43.7040802@t-online.de>
Date: Tue, 21 Mar 2006 06:16:51 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Seth Goldberg <sethmeisterg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: KBUILD_BASENAME hoses nvidia driver / vmware build processes
References: <d1064edf0603201308v4dab8355qee1dcfc9f9b5a611@mail.gmail.com>
In-Reply-To: <d1064edf0603201308v4dab8355qee1dcfc9f9b5a611@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A07213D954C9389ABD99163"
X-ID: STpkQkZDwesTPu-xBrcstIgcZ3WBkbV-Z-C7pDyiC8cpajCPRTlY4t
X-TOI-MSGID: 3165b6bb-4256-4d45-b9af-aa73a65be81a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A07213D954C9389ABD99163
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Seth,

You might want to check

	http://www.nvnews.net/vbulletin/showthread.php?t=62021

for Nvidia's cumulative patch.


Regards

Harri
---------------------------------------------------------------------------
Seth Goldberg wrote:
> Hi,
> 
>    Just an FYI -- I just grabbed 2.6.16 and installed it without a
> problem.  However, when I went to rebuild the nvidia module and vmware
> modules, I discovered that the lack of a definition for
> KBUILD_BASENAME in linux/include/linux/spinlock.h cause these
> components' builds to fail.  I added a stupid workaround and was able
> to build and install these components, but I wanted to bring this to
> your attention.
> 
>   Best wishes,
>   ---S

--------------enig5A07213D954C9389ABD99163
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEH4xLUTlbRTxpHjcRAtIGAKCP3nw/55s61XsWLuQUVG146YaC4QCeM1vw
fNxbQHcUdXK9omzUf8UpHd8=
=cOcs
-----END PGP SIGNATURE-----

--------------enig5A07213D954C9389ABD99163--
