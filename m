Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271963AbTGYHd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 03:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271964AbTGYHd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 03:33:56 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:27281 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S271963AbTGYHdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 03:33:55 -0400
Message-ID: <3F20E0ED.6010800@tequila.co.jp>
Date: Fri, 25 Jul 2003 16:49:01 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Norman Diamond <ndiamond@wta.att.ne.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: Japanese keyboards broken in 2.6
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>
In-Reply-To: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Norman Diamond wrote:

cheap, but working and I think it will stay so until 2.6 goes into final
of distris:

setkeycodes 0x6a 124 1>&2 in your rc.local, local.start or whatever.
works fine for me for alle 2.5x kernels

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/IODtjBz/yQjBxz8RApisAKCG28H8qJQgvpOmOsEmm9+SiPx61ACcDlo2
OuF4YVp0i2KhdTRnZD6fzvY=
=xEBX
-----END PGP SIGNATURE-----

