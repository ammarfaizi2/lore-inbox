Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUC1UZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUC1UZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:25:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:61421 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262455AbUC1UY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:24:58 -0500
X-Authenticated: #1444759
Message-ID: <40673495.3050500@gmx.de>
Date: Sun, 28 Mar 2004 22:24:53 +0200
From: Bernd Fuhrmann <silverbanana@gmx.de>
Reply-To: silverbanana@gmx.de
Organization: Private
User-Agent: Mozilla Thunderbird 0.5+ (Windows/20040317)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: usage of RealTek 8169 crashes my Linux system
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm using a RealTek 8169 1000MBit NIC. However, whenever larger amounts 
of data are being transfered (copying files through smb for instance) 
Linux crashes. It happens after 10MB-100MB transferred data so it's 
never as stable as it should be. The whole System runs fine as long as 
that Realtek 8169 NIC is not used (by transferring data through it). 
When it crashes there is no entry for that event in kern.log and the 
system just hangs.

I'm using:
Linux 2.6.4
gcc 3.3.3
2X Athlon MP 2600 Mhz
Tyan Tiger S2466N-4M Dual / AMD760MPX
2x 512MB ECC/REG Infineon DDR PC266 RAM
Debian (unstable)

Any idea how to fix it? Is that driver getting stable in the next months 
or are there obstacles that should make me buy a different NIC (like 
missing docs for that chipset and stuff like that)?

TIA
Bernd Fuhrmann

