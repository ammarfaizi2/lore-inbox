Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUAKJO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUAKJO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:14:28 -0500
Received: from real-outmail.cc.huji.ac.il ([132.64.1.21]:52899 "EHLO
	mail3.cc.huji.ac.il") by vger.kernel.org with ESMTP id S265809AbUAKJOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:14:25 -0500
Message-ID: <400113EE.6060909@mscc.huji.ac.il>
Date: Sun, 11 Jan 2004 11:14:22 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031119
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Bernhard Kuhn <bkuhn@metrowerks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announcement, patch] real-time interrupts for the Linux kernel
References: <3FFE078D.20400@metrowerks.com>
In-Reply-To: <3FFE078D.20400@metrowerks.com>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
Can this be used for a normal desktop?
Thanks

Bernhard Kuhn wrote:

|
| Hi everybody!
|
| I hope that i can steal enough of your precious time to get your
| attention for a new patch that adds hard real time support to the
| linux kernel (worst case interrupt response time below 5
| microseconds):
|
| The proposed "real time interrupt patch" enables the linux kernel
| for hard-real-time applications such as data aquisition and control
| loops by adding priorities to interrupts and spinlocks.
|
| The following document will describe the patch in detail and how to
| install it:
|
| http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040108/README
|
|
| The patch and a demo application can be downloaded from:
|
|
http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040108/rtirq-20040108.tgz
|
|
|
|
| Comments are highly appreciated!
|
|
| best regards
|
| Bernhard Kuhn, Senior Software Engineer, Metrowerks
|
|
|
|
|
|
|
|
|
|
|
|
| - To unsubscribe from this list: send the line "unsubscribe
| linux-kernel" in the body of a message to majordomo@vger.kernel.org
|  More majordomo info at  http://vger.kernel.org/majordomo-info.html
|  Please read the FAQ at  http://www.tux.org/lkml/


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAARPskj4I0Et8EMgRAhPpAKDY3Eo6cexamFmBiQRnUZ5pJxcnwACgrseV
0v1V9e72RMQ5wD32UNDK0qc=
=E0xz
-----END PGP SIGNATURE-----


