Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132433AbRDAMwl>; Sun, 1 Apr 2001 08:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRDAMwc>; Sun, 1 Apr 2001 08:52:32 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:48136 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132409AbRDAMwV>;
	Sun, 1 Apr 2001 08:52:21 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Weinehall <tao@acc.umu.se>
cc: Simon Garner <sgarner@expio.co.nz>, linux-kernel@vger.kernel.org,
   linux-smp@vger.kernel.org
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot 
In-Reply-To: Your message of "Sun, 01 Apr 2001 12:09:18 +0200."
             <20010401120918.B23618@khan.acc.umu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Apr 2001 05:51:30 -0700
Message-ID: <1168.986129490@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001 12:09:18 +0200, 
David Weinehall <tao@acc.umu.se> wrote:
>On Sun, Apr 01, 2001 at 10:04:17PM +1200, Simon Garner wrote:
>> Thanks, but I do not have watchdog support compiled into the kernel.
>
>Doesn't matter. The NMI-watchdog tries to detect SMP-lockups, and is
>always present. Unless you specifically disable it on boot.

Not any more.  In 2.4.3-ac* the default is no watchdog and it must be
specifically enabled at boot.

