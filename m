Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWBSTPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWBSTPy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBSTPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:15:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12045 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932219AbWBSTPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:15:54 -0500
Date: Sun, 19 Feb 2006 20:15:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: George P Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with unloadable module support... SMP
Message-ID: <20060219191552.GB4971@stusta.de>
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 02:11:17PM -0500, George P Nychis wrote:

> Hi,

Hi George,

> Whenever I compiled unloadable module support into my 2.6.15-r1 kernel, my kernel panic's when booting up when it tries to load a module for the first time.
> 
> I had this problem back with the 2.6.14 kernel, but figured it may have been solved since then so I tried it... and still fails.
> 
> Unloadable module support would be very helpful to me.
> 
> I am using an intel p4 3.0ghz with SMP support built into the kernel.
>...

What is 2.6.15-r1 for a kernel?
Is your problem present in an unmodified 2.6.16-rc4 kernel from 
ftp.kernel.org?

If yes, please send the exact error messages.
You might capture the messages with a digital camera and send a link to 
the photograph.

> Thanks!
> George

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

