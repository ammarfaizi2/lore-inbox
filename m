Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbUAKQCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUAKQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:02:31 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:34713 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S265904AbUAKQCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:02:30 -0500
From: sven kissner <sven.kissner@consistencies.net>
To: Andries.Brouwer@cwi.nl
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Date: Sun, 11 Jan 2004 17:05:06 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
References: <UTC200401111358.i0BDwIM08113.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200401111358.i0BDwIM08113.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401111705.30788.sven.kissner@consistencies.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 11 January 2004 14:58, Andries.Brouwer@cwi.nl wrote:
>
> Did you try using setkeycodes? Say
>
> # setkeycodes 91 120 92 121
>
> to map scancode 0x91 to keycode 120 and 0x92 to 121.

sure but it's not working:
<-- snip -->
# setkeycodes 91 120
setkeycode: code outside bounds
usage: setkeycode scancode keycode ...
 (where scancode is either xx or e0xx, given in hexadecimal,
  and keycode is given in decimal)
<-- snap -->

sven
- -- 
..never argue with idiots. they drag you down to their level and beat you with 
experience..
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAAXRGPV/e7f4i4AERAiTgAJ9cyUsE8C77ZYkW2w6OAeQH6qyaogCfSLJ1
qt8jQWWse/p6Ya32pQImpwE=
=nK3F
-----END PGP SIGNATURE-----
