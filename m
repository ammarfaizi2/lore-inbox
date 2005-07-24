Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVGXSy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVGXSy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 14:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVGXSy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 14:54:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42763 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261436AbVGXSy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 14:54:27 -0400
Date: Sun, 24 Jul 2005 20:54:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Martin MOKREJ <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel version
Message-ID: <20050724185419.GV3160@stusta.de>
References: <42E04D11.20005@ribosome.natur.cuni.cz> <20050722231126.GB3160@stusta.de> <42E3E1BC.2050509@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E3E1BC.2050509@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 08:45:16PM +0200, Martin MOKREJ? wrote:

> Hi Adrian,

Hi Martin,

>  well, the idea was to give you a clue how many people did NOT complain
> because it either worked or they did not realize/care. The goal
> was different. For example, I have 2 computers and both need current acpi
> patch to work fine. I went to bugzilla and found nobody has filed such bugs
> before - so I did and said it is already fixed in current acpi patch.
> But you'd never know that I tested that successfully. And I don't believe
> to get emails from lkml that I installed a patch and it did not break
> anything. I hope you get the idea now. ;)

in your ACPI example there is a bug/problem (ACPI needs updating).

And ACPI is a good example where even 1000 success reports wouldn't help 
because a slightly different hardware or BIOS version might make the 
difference.

Usually "no bug report" indicates that something is OK.
And if you are unsure whether an unusual setup or hardware is actually 
tested, it's usually the best to ask on linux-kernel whether someone 
could test it.

> Martin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

