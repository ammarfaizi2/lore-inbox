Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTLATLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 14:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTLATLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 14:11:31 -0500
Received: from mail.ondacorp.com.br ([200.195.196.14]:20385 "EHLO
	mail.ondacorp.com.br") by vger.kernel.org with ESMTP
	id S263927AbTLATLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 14:11:30 -0500
Message-ID: <3FCB925B.3020904@arenanetwork.com.br>
Date: Mon, 01 Dec 2003 17:11:23 -0200
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Organization: ArenaNetwork Lan House & Cyber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031026 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Hardware] P4 thermal monitor
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

Does the P4 didn't have thermal acpi monitor? As pointed by some 
gdesklets monitors, i've enabled acpi + thermal modules, but cannot read 
values (no such file in /proc/acpi/thermal_zone). In AMD Athlon 2.8+ i 
can monitor its value.

Am i missing something?

Asus p4p800-d, p4 2.4c ht enabled, 2.6.0-test11.

Also, please point me to some other useful docs in this area.

dmesg output:

# modprobe acpi
# modprobe thermal

ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)

Please c/c me as i'm not subscribed. Thanks in advance.
--
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br
