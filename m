Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131758AbRCQUYT>; Sat, 17 Mar 2001 15:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbRCQUYA>; Sat, 17 Mar 2001 15:24:00 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:13061 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S131762AbRCQUXz>;
	Sat, 17 Mar 2001 15:23:55 -0500
Date: Sat, 17 Mar 2001 15:23:14 -0500
From: Zach Brown <zab@zabbo.net>
To: John Heil <kerndev@sc-software.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE UDMA on a CMD-648 Chip
Message-ID: <20010317152314.A22354@tetsuo.zabbo.net>
In-Reply-To: <Pine.LNX.3.95.1010315113407.21451A-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1010315113407.21451A-100000@scsoftware.sc-software.com>; from kerndev@sc-software.com on Fri, Mar 16, 2001 at 11:03:40AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't find the chip's datasheet. CMD only gives it to direct customers.
> I do have the datasheet for the CMD-646U, a prior UDMA supporting chip.

Have you tried mailing them?.  I sent mail to something silly like
support@cmd.  After they found the right person for me to talk to, I
mentioned wanting to play with linux support, and he happily sent the
datasheets for the 648 and 649.

I use andre's 2.2 ide patches to get support for it..

-- 
 zach
