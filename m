Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVBIGOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVBIGOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 01:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVBIGOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 01:14:41 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:33932 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261793AbVBIGOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 01:14:39 -0500
Message-ID: <4209AA42.1030606@tequila.co.jp>
Date: Wed, 09 Feb 2005 15:14:26 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1: two oops on startup
References: <20050204103350.241a907a.akpm@osdl.org>	<4209A6DA.109@tequila.co.jp> <20050208220903.190c02af.akpm@osdl.org>
In-Reply-To: <20050208220903.190c02af.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/09/2005 03:09 PM, Andrew Morton wrote:
> Clemens Schwaighofer <cs@tequila.co.jp> wrote:
> 
>>during startup I get too oops on my Box
> 
> 
> Yes, it is being worked on.  You'll need to CONFIG_INOTIFY=n, thanks.

okay, thanks.

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCCapCjBz/yQjBxz8RAmcKAJ4oYmg9aLy07R7bXfOVjRza+9N9FACgty/B
LiRsNye+unxwpJXzc/PYyTw=
=HP/o
-----END PGP SIGNATURE-----
