Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267541AbUHPK4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267541AbUHPK4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHPK4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:56:30 -0400
Received: from dev.tequila.jp ([128.121.50.153]:21002 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S267541AbUHPK4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:56:20 -0400
Message-ID: <412092C8.1050102@tequila.co.jp>
Date: Mon, 16 Aug 2004 19:56:08 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeon FB slightly broken in 2.6.8.x
References: <411F5F7F.9050403@tequila.co.jp>	 <1092608961.9529.23.camel@gaston>  <411FFC3B.9050808@tequila.co.jp> <1092622048.9529.38.camel@gaston>
In-Reply-To: <1092622048.9529.38.camel@gaston>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin Herrenschmidt wrote:

|
| Does it disappear if you use video=radeonfb:noaccel on the kernel
| command line ?

fb works fine with noccel given.

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBIJLIjBz/yQjBxz8RAtZfAKCYGdb/AjheuVtrwTZ5QhnTiRJinQCfXvJd
pZ+ilA1VPpzdb4FURDP1EJg=
=FeHS
-----END PGP SIGNATURE-----
