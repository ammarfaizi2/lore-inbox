Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTLOHvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 02:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTLOHvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 02:51:38 -0500
Received: from mail1.cc.huji.ac.il ([132.64.1.17]:28567 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S263345AbTLOHvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 02:51:35 -0500
Message-ID: <3FDD6804.5010708@mscc.huji.ac.il>
Date: Mon, 15 Dec 2003 09:51:32 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031119
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Harry McGregor <hmcgregor@espri.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6
References: <20031201062052.GA2022@frodo>	 <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>	 <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com> <3FDC0BAC.8020909@mscc.huji.ac.il>	 <3FDC8957.4000602@yahoo.es>  <3FDC9EC8.1000908@mscc.huji.ac.il> <1071473021.30831.5.camel@Sony>
In-Reply-To: <1071473021.30831.5.camel@Sony>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Harry McGregor wrote:

| On Sun, 2003-12-14 at 10:32, Voicu Liviu wrote:
|
|> Because i use lvm2 and I could not find the way to get back to
|> lvm1 Any clue?
|
|
| How about using the patches for 2.4 to give you LVM2 support?
|
| http://people.sistina.com/~thornber/

This url?
http://people.sistina.com/~thornber/patches/2.4-stable/2.4.22/2.4.22-dm-1/
I'll just get the 2.4.23 vanilla and patch it? I'll try
Thanks

|
| We have it running on one system right now, in fact it is part of
| the reason that we manually patched our 2.4.21 to fix the local
| root exploit that was fixed in 2.4.23, we just had too many
| external patches (FreeSwan, DeviceMapper, XFS, etc) on that system,
| to do patch and recompile in a reasonable amount of time.
|
|
| Harry
|
|> Liviu
|
|
|
| - To unsubscribe from this list: send the line "unsubscribe
| linux-kernel" in the body of a message to majordomo@vger.kernel.org
|  More majordomo info at  http://vger.kernel.org/majordomo-info.html
|  Please read the FAQ at  http://www.tux.org/lkml/


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3WgCkj4I0Et8EMgRApIvAKDO8umYrrSqDodby3OWmxwY9x5ejgCg7wZ+
u5SiceDoteNq61XIVK7vD54=
=5qUw
-----END PGP SIGNATURE-----


