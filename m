Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbTL1LQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 06:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTL1LQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 06:16:16 -0500
Received: from 66-141-88-11.ded.swbell.net ([66.141.88.11]:54029 "EHLO
	lcisp.com") by vger.kernel.org with ESMTP id S265078AbTL1LQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 06:16:15 -0500
From: "Kevin Krieser" <kkrieser@lcisp.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.7 (future kernel) wish
Date: Sun, 28 Dec 2003 05:17:11 -0600
Message-ID: <011801c3cd34$239b0020$6e01a8c0@athlon2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <3FEE4929.4000500@backtobasicsmgmt.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XP came with an option that I've seen on USB hard drives where it won't
cache writes by default.  It is in Device Manager, and called Optimize
for quick removal.  You can also enable write caching, which requires
the use of the Safe Removal icon.

I don't recall 2000 having this option.

With Linux, I'm just ingrained to umount first.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Kevin P.
Fleming
Sent: Saturday, December 27, 2003 9:08 PM
To: Jim Crilly
Cc: Joshua Schmidlkofer; David B. Stevens; Helge Hafting; Jos Hulzink;
Linux Kernel Mailing List
Subject: Re: 2.7 (future kernel) wish


Jim Crilly wrote:

> 'safely' removed. I also believe Windows mounts any removable device
> synchronously so that if you do pull it out prematurely the damage
done 
> is limited.

Nope, when I put stuff onto a CF card via CF-to-USB adapter Windows 
still buffers writes to the media while the user interface goes on about

its business. The only media that I've ever seen Windows use 
synchronously is old-style floppy disks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

