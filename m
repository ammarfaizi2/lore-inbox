Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135453AbRDMJk4>; Fri, 13 Apr 2001 05:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135454AbRDMJkq>; Fri, 13 Apr 2001 05:40:46 -0400
Received: from [213.96.124.18] ([213.96.124.18]:36074 "HELO dardhal")
	by vger.kernel.org with SMTP id <S135453AbRDMJkl>;
	Fri, 13 Apr 2001 05:40:41 -0400
Date: Fri, 13 Apr 2001 11:41:15 +0000
From: =?us-ascii?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: bug in kernel 2.2.19
Message-ID: <20010413114115.A668@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010413085623.A280@pisidlo.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010413085623.A280@pisidlo.sh.cvut.cz>; from J.Gregor@sh.cvut.cz on Fri, Apr 13, 2001 at 08:56:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 13 April 2001, at 08:56:23 +0200,
Jan Gregor wrote:

> Hi
>  Kernel 2.2.19 downloaded from www.kernel.org sometimes when I boot from lilo
> reports after "uncompressing linux ..." and blank line shows "crc error"
> and halts.
> [...]
>
Same behavior here, as I reported some days ago on this same list (with no
response). 2.2.19 halts nearly always on boot, just before "Uncompressing
linux...". 2.2.18 reboots at the same point in the boot process, but the
system ends up booting about 10-20% of the times. I've had no problems with
Debian Potato's 2.2.17 kernel version.

However, booting any of the above kernels from a floppy works fine 100% of
times. So I wonder if this could be a problem with my hard disk's cache or
something related. I've observed that the "Loading linux" progress
indicator is much faster with kernels that give problems than with kernels
that don't.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

