Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264918AbUFHJuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUFHJuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUFHJui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:50:38 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:27306 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S264918AbUFHJu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:50:29 -0400
Message-ID: <40C58BD2.8040001@tequila.co.jp>
Date: Tue, 08 Jun 2004 18:50:10 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <20040607140511.GA1467@elf.ucw.cz> <40C47B94.6040408@scienion.de> <20040607144841.GD1467@elf.ucw.cz> <40C53D80.2080603@tequila.co.jp> <20040608085814.GA1269@elf.ucw.cz> <40C580BE.1030802@tequila.co.jp> <20040608091709.GC2569@elf.ucw.cz>
In-Reply-To: <20040608091709.GC2569@elf.ucw.cz>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
| Hi!
|
|
|>|>| PCMCIA... well, that's another obsolete technology. Too bad.
|>|>
|>|>PCMCIA is obsolete? Did I miss something, or was this a joke?
|>|
|>|
|>| Obsoleted by cardbus, I believe. (cardbus cards look like PCMCIA
|>| cards, but electrical protocol is different) Plus, as someone else
|>| noted, stuff moves into mainboard. USB also replacs part of what
|>| PCMCIA was for.
|>
|>hmm, I didn't know that there is a change from PCMCIA to cardbus.
|>Thought still there are lot of pcmcia stuff around. wlan cards, eg my
|>dial up card (CF card into a PCMCIA adapter). Well I wouldn't abandon
|>PCMCIA so fast. At least the linux kernel is know for beeing able to use
|>very old hardware in a very good way ...
|
|
| Yes, pcmcia still survives in form of compactflash, mostly used by
| low-powered handhelds etc. That's where ISA survives too.

well and low-powered handhelds are one field where linux should run :)
at least on my zaurus its running happily [okay this doesn't have a
pcmcia slot, just an sd/card and cf/card]

| I agree that supporting PCMCIA is usefull, and that linux should run
| on old hardware; but you can see that PCMCIA and APM is in "old
| hardware" category, along with ISA, Pentium I CPUs and serial ports.

Well I wouldn't put PCMCIA into the same part as ISA and Pentium I,
because my 2 year old Sonylaptop with a Pentium-M 4 1.5Ghz has PCMCIA
slots ... So its not like it is found only on stone old Laptops.

| Linux still tries to support 386 cpus, and its right. However its not
| same level of support as modern hardware.

yeah but its very rare to find 386 (except perhaps junkyards), but its
very common to find PCMCIA. way more easy than Pentium I or ISA slots ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxYvRjBz/yQjBxz8RArD4AKCehJaV3Rrh/U0kLuEvJB5mo7AABQCfSHgK
Dpl/LGbWYG9cP8K33LQlef4=
=Ik+A
-----END PGP SIGNATURE-----
