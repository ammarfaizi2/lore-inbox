Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293112AbSBWICv>; Sat, 23 Feb 2002 03:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293113AbSBWICl>; Sat, 23 Feb 2002 03:02:41 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:41744 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S293112AbSBWIC0>; Sat, 23 Feb 2002 03:02:26 -0500
Date: Sat, 23 Feb 2002 01:02:22 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.18-rc4 does not boot
Message-ID: <20020223010222.A5681@mail.harddata.com>
In-Reply-To: <20020222190538.A3819@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020222190538.A3819@mail.harddata.com>; from michal@harddata.com on Fri, Feb 22, 2002 at 07:05:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 07:05:38PM -0700, Michal Jaegermann wrote:
> On Monday, Feb 18, I posted a message that 2.4.18-pre9-ac4
> fails to boot on my machine with
> 
> FAT: bogus logical sector size 0
> FAT: bogus logical sector size 0
> Kernel panic: VFS: Unable to mount root fs on 03:00
> 
> messages.  2.4.18-rc1, and many different kernels, do not have
> troubles of that sort.  Tonight I found to my dismay that the
> same trouble afflicted 2.4.18-rc4.  No, I do not know why this
> happens; at least at this moment.

Well, I still do not know the answer; when I started to investigate it
decided to work and I am running it right now.  Bootloader not in a
mood?  Quite possible.  Boot commands used with 2.4.18-rc1 and
2.4.18-rc4 differ by one character (more precisely, a digit :-).  Sorry
for a premature alarm.

BTW - I noticed that although I wrote that Monday I failed to mention
this in the message quoted.  The machine is Alpha (Nautilus).

  Michal
