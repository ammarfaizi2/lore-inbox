Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130807AbQLELL6>; Tue, 5 Dec 2000 06:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbQLELLj>; Tue, 5 Dec 2000 06:11:39 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:5523 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130807AbQLELLc>; Tue, 5 Dec 2000 06:11:32 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Dec 2000 02:40:59 -0800
Message-Id: <200012051040.CAA03227@adam.yggdrasil.com>
To: lgb@viva.uti.hu
Subject: Re: Any good reason why these is so much memory "reserved"?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt writes:
>On Tue, Dec 05, 2000 at 02:18:59AM -0800, Adam J. Richter wrote:
>>       Recently, I have had occasion to build a system on a floppy
>> for a 4MB machine that we use as a router.  In the past, the kernels
>
>I've played with this too. You can't use ramdisk easily on such a system.
[snip]

	We are using such a system and have been for years.
If you'll reread my posting, you will see that it is about relatively
recent changes to the kernel that apparently have broken this.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
