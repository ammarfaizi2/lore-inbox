Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbVCDNYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbVCDNYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVCDNWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:22:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16645 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262928AbVCDNSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:18:25 -0500
Date: Fri, 4 Mar 2005 14:18:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, mike@waychison.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport complete_all
Message-ID: <20050304131824.GA3327@stusta.de>
References: <422817C3.2010307@waychison.com> <58cb370e0503040240314120ea@mail.gmail.com> <20050304031504.4ea49f83.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304031504.4ea49f83.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:15:04AM -0800, Andrew Morton wrote:
>...
> So it's a sensible part of the completion API from a regularity-of-the-API
> POV.  We use it in the coredump code and I don't think we'd be likely to want
> to rip it out.
>...

Modular coredump code?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

