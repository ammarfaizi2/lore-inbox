Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVAFUEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVAFUEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVAFUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:04:09 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:35528 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263001AbVAFUCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:02:24 -0500
Message-ID: <41DD9968.7070004@comcast.net>
Date: Thu, 06 Jan 2005 15:02:48 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <1697129508.20050102210332@dns.toxicfilms.tv>
In-Reply-To: <1697129508.20050102210332@dns.toxicfilms.tv>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is gonna go on forever.

I tried[1], but I guess development HAS to be in the "stable" branch and
can't be shipped to a similarly managed "volatile" branch for
development, since it obviously makes such a big difference to mainline
kernel developers and less so to home users, third party developers, and
businesses and institutions who rely on a mostly stable codebase to
avoid surprise breakage.

Is this a serious operating system or a running experiment?  Running
experiments have no place in production; if your "stable" mainline
branch is going to continuously add and remove features and go through
wild API and functionality changes, nobody is going to want to use it.
Mozilla doesn't support IE's broken crap "because IE is a moving
target."  Unpredictable API changes and changes to the deep inner
workings of the kernel will make the kernel "a moving target."  If
that's the route you take, it will become too difficult for people to
develope for linux.

[1] http://woct-blog.blogspot.com/2005/01/finally-new-pax.html

Maciej Soltysiak wrote:
| Hi,
|
| I was wondering in the tram today are we close to branching
| off to 2.7
|
| Do the mighty kernel developers have solid plans, ideas, etc
| to start experimental code
|
| Regards,
| Maciej
|
|
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3ZlohDd4aOud5P8RAg02AJ0VhUkRyzvfXzHS8YkQgdWru+VpyQCcCrbA
3rQr6wgKPMLXAl79OsrwdBQ=
=ci1u
-----END PGP SIGNATURE-----
