Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWEVHiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWEVHiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWEVHiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:38:14 -0400
Received: from euklides.vdsoft.org ([82.208.56.17]:58049 "EHLO
	euklides.vdsoft.org") by vger.kernel.org with ESMTP id S932590AbWEVHiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:38:13 -0400
Message-ID: <44716A5F.3070208@vdsoft.org>
Date: Mon, 22 May 2006 09:38:07 +0200
From: Vladimir Dvorak <dvorakv@vdsoft.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APIC error on CPUx
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all,

after mailserver installation im getting these messages from kernel:

APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)

Approximatelly from 2 to 5 messages per 24 hours.

Linux requisities:
Debian 3.1
Linux mailserver 2.6.8-3-686-smp #1 SMP Thu Feb 9 07:05:39 UTC 2006 i686
GNU/Linux

Hardware:
Intel SR1200


Solution from google ?
 "upgrade BIOS firmware"  - but  Im sure the BIOS is the latest.


How serious is this problem ? Does some patch exist to workaround APIC
errors ?
What is the sense of putting "noapic and nolapic" parameters into the
cmdline ? ( Can these parameters cause performance decreasing ? )

Thank you !

Vladimir Dvorak


