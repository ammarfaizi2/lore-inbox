Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUHRTlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUHRTlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUHRTli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:41:38 -0400
Received: from [82.154.232.128] ([82.154.232.128]:48800 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S267551AbUHRTlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:41:36 -0400
Message-ID: <4123B0F0.5050408@vgertech.com>
Date: Wed, 18 Aug 2004 20:41:36 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528 Thunderbird/0.6 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI-Bus
References: <Pine.LNX.4.53.0408181403120.16592@chaos>
In-Reply-To: <Pine.LNX.4.53.0408181403120.16592@chaos>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Richard B. Johnson wrote:

[..]

|
| 0e:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
| 	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
| 	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 28
| 	Memory at f1370000 (64-bit, non-prefetchable) [size=64K]
| 	Memory at f1360000 (64-bit, non-prefetchable) [size=64K]
| 	Capabilities: [40] PCI-X non-bridge device.
| 	Capabilities: [48] Power Management version 2
| 	Capabilities: [50] Vital Product Data
| 	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
|
| The Analogic entries of:
| 	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 25
| don't look much different than the Ethernet controllers, above. Of
| course they are built into the motherboard and claim 64-bits.
|

And they are 64bit. They are connected to a PCI-X bus, not plain PCI.

About your real question, I'm sorry but I don't know :(

Reegards,
Nuno


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBI7DwOPig54MP17wRAqbSAKCjK3jqTJr7ap4XVIulXOJNrBeoIgCdEEAH
Lj5QFVoZj29BFJ1G3sA/kE0=
=ycDw
-----END PGP SIGNATURE-----
