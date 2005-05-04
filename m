Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVEDML6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVEDML6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 08:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVEDML6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 08:11:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53773 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261663AbVEDML4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 08:11:56 -0400
Date: Wed, 4 May 2005 14:11:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to get a git repository?
Message-ID: <20050504121153.GO3592@stusta.de>
References: <4278BF5E.6060002@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4278BF5E.6060002@superbug.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 01:26:06PM +0100, James Courtier-Dutton wrote:

> Hi,

Hi James,

> I am maintainer of a very small part of the Linux kernel.
> EMU10K1 SOUND DRIVER
> 
> This is the old OSS driver for SB Live and Audigy sound cards.
> I have been sent some patches recently, so I was thinking about the best
> way to get them added to the kernel.
>...
> So, can anybody help me with the best way to do this?

They best way to get your patches into the kernel might be to send them 
through Andrew, who will add them to his -mm tree and later forward them 
to Linus.

If I assume correctly that "I have been sent some patches recently" 
means half a dozen patches and the whole amount of patches every year 
might be two dozen, I don't see any real reason for you to not simply 
handling them manually.

> Kind Regards
> 
> James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

