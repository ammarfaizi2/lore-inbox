Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132551AbRDNV5t>; Sat, 14 Apr 2001 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbRDNV5j>; Sat, 14 Apr 2001 17:57:39 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:14077 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S132551AbRDNV5e>;
	Sat, 14 Apr 2001 17:57:34 -0400
To: lomarcan@tin.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI Tape Corruption - update 2
X-Newsgroups: linux.kernel
In-Reply-To: <Pine.LNX.4.31.0104142043340.1271-100000@eris.discordia.loc>
From: chip@valinux.com (Chip Salzenberg)
In-Reply-To: <15063.8582.293619.762113@mercury.st.hmc.edu>
Organization: NASA Calendar Research
Message-Id: <E14oYuQ-0000gf-00@tytlal>
Date: Sat, 14 Apr 2001 15:52:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0104142043340.1271-100000@eris.discordia.loc> you write:
>On Fri, 13 Apr 2001, Nate Eldredge wrote:
>> (32 bytes is the size of a cache line.)  A memory tester might be
>> something to try (I wrote a simple program that seemed to show the
>> error better than memtest86; can send it if desired.)
>
>Already tried that... this system has passed some 20 hours running
>memtest86...

I suggest you try Cerberus:

  https://sourceforge.net/projects/va-ctcs/

which will viciously beat your system to within an inch of its life.
If you have any motherboard problems, they're more likely to show up
with Cerberus than with a simple memtest.
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
