Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUHQDwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUHQDwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUHQDwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:52:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:36511 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268088AbUHQDwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:52:24 -0400
Subject: Re: Radeon FB slightly broken in 2.6.8.x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Eger <eger@havoc.gtf.org>
In-Reply-To: <412092C8.1050102@tequila.co.jp>
References: <411F5F7F.9050403@tequila.co.jp>
	 <1092608961.9529.23.camel@gaston>  <411FFC3B.9050808@tequila.co.jp>
	 <1092622048.9529.38.camel@gaston>  <412092C8.1050102@tequila.co.jp>
Content-Type: text/plain
Message-Id: <1092714246.9538.93.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 13:44:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, any clue ? (go back into this thread), it seems there could be
an offset problem with the accel code still ?

Ben.


On Mon, 2004-08-16 at 20:56, Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Benjamin Herrenschmidt wrote:
> 
> |
> | Does it disappear if you use video=radeonfb:noaccel on the kernel
> | command line ?
> 
> fb works fine with noccel given.
> 
> lg, clemens
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFBIJLIjBz/yQjBxz8RAtZfAKCYGdb/AjheuVtrwTZ5QhnTiRJinQCfXvJd
> pZ+ilA1VPpzdb4FURDP1EJg=
> =FeHS
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

