Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277242AbRJIOO4>; Tue, 9 Oct 2001 10:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277240AbRJIOOq>; Tue, 9 Oct 2001 10:14:46 -0400
Received: from ns.suse.de ([213.95.15.193]:11022 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277236AbRJIOOe>;
	Tue, 9 Oct 2001 10:14:34 -0400
Date: Tue, 9 Oct 2001 16:15:04 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Thomas Hood <jdthood@mail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sysctl interface to bootflags?
In-Reply-To: <1002636089.953.115.camel@thanatos>
Message-ID: <Pine.LNX.4.30.0110091613490.32557-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Thomas Hood wrote:

> Would it be a good idea to do this using the sysctl infrastructure?
> If so, can someone please suggest an appropriate pathname for
> the flag files?  How about "/proc/sys/BIOS/bootflags/diagnostics"
> and "/proc/sys/BIOS/bootflags/PnP-OS" ?
> If this is a bad idea, someone please stop me before I waste my
> time implementing it.

Last week, I pointed you at http://www.codemonkey.org.uk/sbf.c
Can you give a reason why this needs to be done in kernel space ?

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

