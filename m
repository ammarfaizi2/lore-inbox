Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbRL0Sdi>; Thu, 27 Dec 2001 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286443AbRL0Sd3>; Thu, 27 Dec 2001 13:33:29 -0500
Received: from [206.98.161.198] ([206.98.161.198]:16400 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S286434AbRL0SdP>; Thu, 27 Dec 2001 13:33:15 -0500
Subject: Re: Problems booting 2.4.17
From: Edward Muller <emuller@learningpatterns.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1009475886.16791.0.camel@akira.learningpatterns.com>
In-Reply-To: <1009475886.16791.0.camel@akira.learningpatterns.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Dec 2001 13:30:36 -0500
Message-Id: <1009477836.16903.2.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled/Installed 2.4.16 and the machine boots without a problem. 

So is it a 2.4.17 issue or do I need to upgrade something else?

On Thu, 2001-12-27 at 12:58, Edward Muller wrote:
> Hello all.
> 
> I'm having problems booting 2.4.17 on a Mandrake 8.1 system (with all
> current updates).
> 
> When I boot 2.4.17 (with an initrd image) I get the following...
> 
> kernel boots ...
> Creating root device
> mkrootdev: mknod failed: 17
> Mounting root filesyste with flags data=ordered
> Mount: error 16 mounting ext3 flags data=ordered
> ...Tried to remount without flags and fails with the same error...
> Kernel Panic: No initrd found ...
> 
> I am using ext3 / /boot /usr /var & /home filesystems
> 
> 2.4.8-34.1mdk boots fine however.
> 
> I'm about to go try 2.4.16 (it was working with reiserfs partitions
> before).
> 
> The machine is an AMD Athalon 1.3 Ghz on an EPOC board with a 3ware 7800
> series RAID card, with three 75/80 GB drives in a RAID 5 array.
> 
> Anyone else run into something like this? 
> 
> I'll report back about 2.4.16 and if anyone would like more info, just
> shout.
> 
> 
> -- 
> -------------------------------
> Edward Muller
> Director of IS
> 
> 973-715-0230 (cell)
> 212-487-9064 x115 (NYC)
> 
> http://www.learningpatterns.com
> -------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

