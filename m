Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTKGWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTKGWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:01:18 -0500
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:24714 "EHLO ds666")
	by vger.kernel.org with ESMTP id S264337AbTKGNhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 08:37:54 -0500
Message-ID: <3FABA030.9040405@portrix.net>
Date: Fri, 07 Nov 2003 14:37:52 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: test9: suspend no go
References: <3F9BCF7A.7000403@portrix.net> <20031107100609.GA5088@elf.ucw.cz> <3FAB8CA1.7040105@portrix.net> <20031107132146.GC20585@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20031107132146.GC20585@atrey.karlin.mff.cuni.cz>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:

|>Any idea, why the laptop is not powering on again after suspend? I can
|>hold down the power switch as long as I want to, but the laptop doesn't
|>do a thing.
|
|
| Seems like hardware bug? [So you have to remove battery/AC then
| poweron?]
| 								Pavel

Exactly. Pretty annoying. In those days where Windows XP powered the
laptop, this worked, so I'm pretty sure it is no hardware bug. If I
press the power switch, the power & disk light goes on, but nothing happens.
Is there anything w/ acpi I can try?

Jan

ps: Is linux-kernel mailing list down?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/q6AwLqMJRclVKIYRAkXXAJwJ+uo6J+0zylPW1qjOHB6mGJ7gVACfayQR
Vvjg1w1fpkBJ9NHvfrHgy5o=
=b/tN
-----END PGP SIGNATURE-----

