Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUBFRw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUBFRw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:52:58 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32217 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265094AbUBFRw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:52:57 -0500
Date: Fri, 6 Feb 2004 18:52:48 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Christian Unger <chakkerz@optusnet.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040206175248.GE26093@fs.tum.de>
References: <4022BC15.4090502@wanadoo.es> <200402060702.15930.ctpm@rnl.ist.utl.pt> <200402062112.32212.chakkerz@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402062112.32212.chakkerz@optusnet.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 09:12:32PM +1100, Christian Unger wrote:
>...
> >   The kernel is not tainted and was compiled with gcc 2.95.4.
> What is a good version of GCC to use for all of this anyway ? Does / Should it 
> make a difference ? (It probably does, but should it?)

gcc 2.95 is usually a good choice.

But although it's unlikely, it would eliminate one possible problem if 
someone would check whether the problem still exists with a kernel that 
is compiled with e.g. gcc 3.3.2 .

> with kind regards,
>   Christian Unger

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

