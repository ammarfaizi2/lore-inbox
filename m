Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTALW7x>; Sun, 12 Jan 2003 17:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbTALW7w>; Sun, 12 Jan 2003 17:59:52 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:34498 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267622AbTALW6x>; Sun, 12 Jan 2003 17:58:53 -0500
Date: Mon, 13 Jan 2003 00:08:46 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.55 failed to boot with ACPI support
Message-ID: <20030112230846.GA5692@brodo.de>
References: <4967145.1042411725110.JavaMail.nobody@web55.us.oracle.com> <5028.1042412642@www10.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5028.1042412642@www10.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:04:02AM +0100, Alessandro Suardi wrote:
> Andrew Grover wrote:
> 
> > > From: Ole J. Hagen [mailto:olehag_2001@yahoo.no] 
> > > I just wanted to inform that kernel-2.5.55 failes to boot 
> > > when ACPI support is 
> > > compiled in the kernel. 
> > > 
> > > I have following configuration; Dell Optiplex GX-240, Pentium 
> > > 4 (1.5 GHz), ATI RAGE 128.
> >
> > How exactly does it fail?
> 
> My brand new Dell Latitude C640 oopses on boot in 2.5.56 if I
>  have CPU_FREQ config'd in. ACPI without CPU_FREQ is okay - well,
>  it screws my framebuffer screen (what 2.4.21-pre3 doesn't) when
>  the ACPI code does its bootup printk's, but after that the
>  screen recovers.
>
> ...
>
> Back on topic, if you're interested I can rebuild my 2.5.56 with
>  CPU_FREQ and write down the backtrace of the oops.

Would be great if you could do that - and tell what oops it is (NULL pointer
dereference etc.), in case you still see that on your screen.

	Dominik
