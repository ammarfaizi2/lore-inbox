Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbTLNHGg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 02:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbTLNHGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 02:06:35 -0500
Received: from real-outmail.cc.huji.ac.il ([132.64.1.18]:64188 "EHLO
	mail2.cc.huji.ac.il") by vger.kernel.org with ESMTP id S265362AbTLNHGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 02:06:33 -0500
Message-ID: <3FDC0BAC.8020909@mscc.huji.ac.il>
Date: Sun, 14 Dec 2003 09:05:16 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031119
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6
References: <20031201062052.GA2022@frodo> <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet> <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com>
In-Reply-To: <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Rychter wrote:

|>>>>> "Marcelo" == Marcelo Tosatti
|>>>>> <marcelo.tosatti@cyclades.com> writes:
|
| [...] Marcelo> 2.6 is already stable enough for people to use it.
|
| Yes, that's an old post I'm responding to, but I've just given 2.6
| a try on my desktop machine, and the above statement seems even
| more annoying. I hit the following problems:
|
| -- I had to wrestle ATI drivers into compiling, they finally did,
| but the kernel prints scary-looking warnings with call stacks,
| about "sleeping function called from invalid context at
| mm/slab.c:1856, -- modules don't autoload for some reason (though
| I'm sure that could be solved), -- bttv does not compile, so no
| video input for me, -- drivers for my telephony card (from Digium)
| are not 2.6-ready, so no telephony support for me, -- I have just
| frozen the machine hard by copying files over NFS and doing a
| simulation write to an ATAPI CD-RW at the same time.
|
| I haven't even gotten to VMware and user-mode Linux, which I also
| need, and I'm not even dreaming about getting my scanner to work.
| Not to mention that on my laptop there would be an entirely
| different set of issues, and software suspend in 2.6 is, well,
| still lacking.
|
| So, as for me, 2.6 is a definite no-no. I see no advantage
| whatsoever in running it, it caused me nothing but pain, and there
| is no improvement that I could see that would justify the upgrade.
|
| So please be careful when making statements like that. 2.6 is *NOT*
|  stable enough nor ready enough for people to use it, unless those
| people have a narrow range of hardware on which the 2.6 kernel has
| actually been tested (translation: they have the same hardware as
| the main developers do).
|
| --J.


My specs:
Cpu:Athlon XP 2500+ BARTON {10x190}
Mobo:EPOX 8RDA3 + NFORCE 2
Ram:Corsair TWINX 512 3200LL{dual channel/11-3-2-2.0}
Fan:Cooler Master +7
Video:Hercules 3D Prophet 9600 PRO Radeon 128MB

My Hercules 3D Prophet 9600 PRO Radeon simply freezes my comp. with
ati-drivers from ati.com so I need to press reset!(so I only can run
console)
My sound (nvidia on board) works very shitty and I have no control on
it (level sound I mean).
I was running 2.4.23 vanilla + lvm1 so I moved to 2.6 vanilla+lvm2 and
now I can not move back

These are my biggest problems with 2.6.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3Aurkj4I0Et8EMgRArxCAKDbp0uE5mIhA5/5C+v/71tscWneHQCg0h3R
RF2NIf4bbQ3XEMjV6eEePJI=
=7jBp
-----END PGP SIGNATURE-----


