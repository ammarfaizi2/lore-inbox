Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135696AbRDXQTE>; Tue, 24 Apr 2001 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135697AbRDXQSz>; Tue, 24 Apr 2001 12:18:55 -0400
Received: from think.faceprint.com ([166.90.149.11]:2820 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S135696AbRDXQSq>; Tue, 24 Apr 2001 12:18:46 -0400
Message-ID: <3AE5A762.675581E4@faceprint.com>
Date: Tue, 24 Apr 2001 12:18:42 -0400
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: random reboots
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help!

My machine seems to be rebooting at random.  Actually, it's more like
the screen blanks, and suddenly the BIOS is going through POST.  There
may be a reset-button gnome in my case putting a jumper over the reset
pins, but I seriously doubt it. ;-) I recently tried to switch from APM
to ACPI, when i upgraded from ac9 to ac11, so I thought that might be
the cause.  So I switched back to APM with ac13 (I had the same ac12
compile problems as the rest of the world).  It's still rebooting,
without any aparent cause.

I upgraded the BIOS on this Asus A7V sometime in the past week, but I
honestly don't remember when.  From 1005C to 1007.  This was released in
march, so I assumed it was pretty stable, but it could be the cause. 
I'm going to go downgrade now, but is this more likely to be a kernel
bug, or a hardware bug/new bios bug?

Thanks,
Nathan
