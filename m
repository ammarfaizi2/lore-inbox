Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTH2At0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 20:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTH2AtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 20:49:25 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:33624 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id S264380AbTH2AtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 20:49:24 -0400
Message-ID: <3F4EA30C.CEA49F2F@vtc.edu.hk>
Date: Fri, 29 Aug 2003 08:49:16 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Single P4, many IDE PCI cards == trouble??
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Junkmail-Whitelist: YES (by domain whitelist at pandora.vtc.edu.hk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Folks,

With a single 2.26GHz P4, an Asus P4B533-E motherboard, is it possible
to reliably use two additional PCI IDE cards (using SI680), one hard
disk per channel, and have the thing work reliably?

Could this be the cause of my lockups?  I have a total of 6 ATA133
hard disks, one DVD player all connected to the two IDE channels on
the motherboard, and one disk to each of the channels of the SI680
cards.

Some people have told me that this is just asking for trouble, and
that I should buy a 3ware card instead.

I am also using software RAID1, RAID5 with LVM on top.

My machine locks solid at unpredictable intervals with no response
from keyboard lights, no Alt-Sysrq-x response, etc, with a wide
variety of 2.4.x kernels, including 2.4.22.

--
Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



