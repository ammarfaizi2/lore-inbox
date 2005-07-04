Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVGDT1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVGDT1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 15:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVGDT1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 15:27:37 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:21637 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261575AbVGDT1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 15:27:34 -0400
Message-ID: <42C98DB5.9090603@grimmer.com>
Date: Mon, 04 Jul 2005 21:27:49 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: aaron@assonance.org
CC: hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <9a8748490507031832546f383a@mail.gmail.com>	 <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <727e501505070411594cac3c45@mail.gmail.com>
In-Reply-To: <727e501505070411594cac3c45@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Aaron Cohen wrote:

> Can't the accelerometer be used as an input device in addition to just
> being a "about to fall detector?"

Yes, it can - the kernel driver just prints the data taken from the
accelerometer. It's up to another application to make sense out of this.
One purpose would be the mentioned "fall detector" that would then
instruct the disk drive to part its head.

> I seem to remember games where the the input method involved tilting
> the device in the direction you want a marble to roll or something
> like that.

Correct, that would be one option. Mark Smith (they IBM guy who wrote up
the information required to write the kernel module) actually mentioned
he had patched SDL to support the accelerometer as an input device.

Playing "Neverball" by tilting your Laptop sounds like fun :)

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyY20SVDhKrJykfIRAjo/AJ0dyN0GXE7U5H3+updjuMKALoHlXQCdExrA
FwgCv2ELKCc9cC0M47E5B+w=
=pigJ
-----END PGP SIGNATURE-----
