Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280902AbRKOP1F>; Thu, 15 Nov 2001 10:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280904AbRKOP0z>; Thu, 15 Nov 2001 10:26:55 -0500
Received: from [212.18.232.186] ([212.18.232.186]:12554 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S280902AbRKOP0s>; Thu, 15 Nov 2001 10:26:48 -0500
Date: Thu, 15 Nov 2001 15:26:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: pil@mailnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: HFS-Bug in Kernel 2.4.12 and above
Message-ID: <20011115152636.A1259@flint.arm.linux.org.uk>
In-Reply-To: <3BF3DB8A.CD1BBCE6@mailnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF3DB8A.CD1BBCE6@mailnet.de>; from pil@mailnet.de on Thu, Nov 15, 2001 at 04:13:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 04:13:14PM +0100, pil@mailnet.de wrote:
> Kernel 2.4.12 is no more able to handle two floppy drives with hfs
> formated floppies.
> 
> You can recreate the failure if you have two floppy drives, use Kernel
> 2.4.12 (and above) with loadable module support for hfs- and
> vfat-floppies and try to mount the first one with a hfs formated floppy
> inside. If you unmount the floppy drive again you will get a
> segmentation fault and an uninterruptible sleep for the mount PID. You
> cannot mount this drive again.
> 
> For all other see attached file 'report'.
> 
> Regards
> 
> Wolfgang Pichler
> ARM MFM AND FLOPPY DRIVERS
> P:      Dave Gilbert
> M:      linux@treblig.org
> S:      Maintained
> 

What is the relevance of the above past from the Linux CREDITS file?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

