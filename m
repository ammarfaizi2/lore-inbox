Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135970AbRAMAqb>; Fri, 12 Jan 2001 19:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135954AbRAMAqV>; Fri, 12 Jan 2001 19:46:21 -0500
Received: from linuxcare.com.au ([203.29.91.49]:30730 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S135970AbRAMAqM>; Fri, 12 Jan 2001 19:46:12 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 13 Jan 2001 11:45:07 +1100
To: Mauelshagen@sistina.com
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com, lvm@sistina.com
Subject: Re: *** ANNOUNCEMENT *** LVM 0.9.1 beta1 available at www.sistina.com
Message-ID: <20010113114507.D15915@linuxcare.com>
In-Reply-To: <20010113011532.B21587@srv.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010113011532.B21587@srv.t-online.de>; from Heinz.Mauelshagen@t-online.de on Sat, Jan 13, 2001 at 01:15:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> a tarball of the Linux Logical Volume Manager 0.9.1 beta1 is available now at
>    <http://www.sistina.com/>
> for download (Follow the "LVM download page" link).

Have a look at 2.4, arch/sparc64/kernel/ioctl32.c

Would it be possible to clean up the ioctl interface so we dont need
such large hacks for LVM support? I can do the work but I want to be
sure you guys will agree to it.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
