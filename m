Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUAVWpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266464AbUAVWpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:45:20 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:58301 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S266463AbUAVWpO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:45:14 -0500
From: sven kissner <sven.kissner@consistencies.net>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Date: Thu, 22 Jan 2004 23:49:33 +0100
User-Agent: KMail/1.6
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <UTC200401111903.i0BJ3nV06355.aeb@smtp.cwi.nl> <200401112035.38414.sven.kissner@consistencies.net> <20040111194657.GA1975@win.tue.nl>
In-Reply-To: <20040111194657.GA1975@win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401222349.39781.sven.kissner@consistencies.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 11 January 2004 20:46, Andries Brouwer wrote:
> On Sun, Jan 11, 2004 at 08:35:34PM +0100, sven kissner wrote:
> > nice! i can assign the keys.

there are still 4 keys (f-keys with f-lock active) which i can't map to 'free' 
keycodes: no matter which value i assign with sk, they always get mapped to 
already mapped keys which causes them to collide (e.g. f-lock+f3 always gets 
mapped to keycode 108 which is already assigned to 'enter' on the numpad)

note that those collisions happen inside x (4.3). writing this, i recognize 
that this is probably more of a x-problem. anyhow, maybe someone with the 
same problems or even solutions is followig this thread ;)

keep on rockin'
sven
- --
..never argue with idiots. they drag you down to their level and beat you with 
experience..
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAEFOCPV/e7f4i4AERAqIOAKCXjtguVq/sIYpRQ2lzW8slHcCiLwCeIZg6
RxlmStFfzZuWLvQJ8Kmc3j0=
=FI3y
-----END PGP SIGNATURE-----
