Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRDAUWe>; Sun, 1 Apr 2001 16:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRDAUWY>; Sun, 1 Apr 2001 16:22:24 -0400
Received: from [63.95.87.168] ([63.95.87.168]:49162 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132553AbRDAUWN>;
	Sun, 1 Apr 2001 16:22:13 -0400
Date: Sun, 1 Apr 2001 16:21:01 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
Message-ID: <20010401162101.E17271@xi.linuxpower.cx>
In-Reply-To: <200104011754.KAA20725@work.bitmover.com> <200104011943.f31JhqL136501@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <200104011943.f31JhqL136501@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sun, Apr 01, 2001 at 03:43:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2001 at 03:43:52PM -0400, Albert D. Cahalan wrote:
> I'm really sick of being buried in useless information. The signal
> gets lost in the noise. It is easy to discard automatically generated
> bug reports, and way too annoying to wade through the crud.
> 
> When network connections hang, the console-tools package version
> isn't likely to be of any use. When ramfs leaks memory, nobody needs
> the content of /proc/pci.
> 
> Sometimes the bit of crud are HUGE. Imagine the hardware info
> for a 64-way SGI or Sun box with plenty of devices attached.

Disk space is 'free'. The information should be stored in a database where
you can retrieve the information you need at will, while the back-end can
statistically analyze the whole of the information looking for anomalies you
would never have expected (like that network hang actually being caused by
console-tools :) ).
