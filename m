Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSJPUEr>; Wed, 16 Oct 2002 16:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSJPUEr>; Wed, 16 Oct 2002 16:04:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261341AbSJPUEj>; Wed, 16 Oct 2002 16:04:39 -0400
Date: Wed, 16 Oct 2002 16:10:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Cuss <mcuss@cdlsystems.com>
cc: jamesclv@us.ibm.com, Samuel Flory <sflory@rackable.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
In-Reply-To: <0d3901c2754c$7bf17060$2c0e10ac@frinkiac7>
Message-ID: <Pine.LNX.3.95.1021016160728.1422A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Mark Cuss wrote:

> Speaking of performance.... :)
> 
> Has anyone done any testing on a dual CPU configuration like this?  I've
> been testing this box with both the RedHat 8 Stock Kernel (2.4.18.something)
> and 2.4.19 from kernel.org.  Currently, I can't make the thing perform
> anywhere near as fast as my Dual PIII 1 Ghz box (running 2.4.7 for the last
> 325 days...) .  I've been compiling the same block of code on both the
> machines and comparing the times.  The PIII box is around 7 s, while the new
> Xeon Box is 13 or 14s...
> 
> My thinking was that since the CPUs are much faster, and the FSB is faster,
> and the disk controller is faster, that the computer would be faster.
> 
> The hardware is obviously faster, I'm sure its just something I've done
> wrong in the kernel configuration...  If anyone has any advice or words of
> wisdom, I'd really appreciate them...
> 
> Thanks in advance,
> 
> Mark


Try using the exact same disk drive(s) with both mother-boards if
you are looking at compile-times for comparison. Use the same drive(s)
when testing both motherboards.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

