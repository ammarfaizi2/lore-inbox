Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUJOOlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUJOOlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUJOOlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:41:42 -0400
Received: from promon2.netbox.cz ([83.240.31.171]:38664 "EHLO brno.promon.cz")
	by vger.kernel.org with ESMTP id S267904AbUJOOlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:41:40 -0400
To: linux-kernel@vger.kernel.org
Subject: promise (105a:3319) unattended boot
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
From: a.ledvinka@promon.cz
Date: Fri, 15 Oct 2004 16:41:37 +0200
X-MIMETrack: Serialize by Router on Brno/Micronic(Release 6.5.2|June 01, 2004) at
 15.10.2004 16:41:41,
	Serialize complete at 15.10.2004 16:41:41
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Got here http://pciids.sourceforge.net/iii/?i=105a3319
As http://linux.yyz.us/sata/faq-sata-raid.html#tx4 calls it 
soft/accelerator raid version
Going to use latest kernel from /pub/linux/kernel/v2.4/

But bios even with keyboard unplugged requires me to press one of 2 keys 
to either define array OR continue booting in case no array is defined.

What would you recommend me to do?
- stay with ft3xx module from promise  and 10 level RAID array and not use 
sata_promise?
- define some array in bios and completely ignore that fact and use 
sata_promise, bypass bios and define custom linux soft raid arrays?
- anything else (no bios flashing and no hw hacking)?

AlL.

please CC me... but anyway if you forget i will have a look into archive.

