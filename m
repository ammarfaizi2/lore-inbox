Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFLFE>; Wed, 6 Dec 2000 06:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLFLEy>; Wed, 6 Dec 2000 06:04:54 -0500
Received: from smtp1.ihug.co.nz ([203.109.252.7]:14354 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129183AbQLFLEh>;
	Wed, 6 Dec 2000 06:04:37 -0500
Message-ID: <3A2E160E.ECD6DEE9@ihug.co.nz>
Date: Wed, 06 Dec 2000 23:33:50 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11-ac4-smp i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <Pine.LNX.4.30.0012041249020.22668-100000@anime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis wrote:

> > No improvement in condition, alas.
> HPT366 on BP6 is just broken. Corruption and lockups happen under
> microsoft-windoze as well.

I think I'll run with leaving the HDD on the ATA-33 controller. 
After all; the "100% speedup" isn't really that 
A) noticable, or 
B) worth this.

> -Dan

Thanks to all the little people that helped - Appreciated :)


Gerard Sharp
Two Penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
