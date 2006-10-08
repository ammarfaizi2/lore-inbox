Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWJHRsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWJHRsH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWJHRsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:48:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9231 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751296AbWJHRsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:48:05 -0400
Date: Sun, 8 Oct 2006 19:47:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>, pavel@suse.cz
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
Subject: Re: Funky "Blue screen" issue while rebooting from X with 2.6.18-git21
Message-ID: <20061008174759.GF6755@stusta.de>
References: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:16:41PM +0200, Jesper Juhl wrote:
> I have a strange "problem" with 2.6.18-git21 that I've never had with
> any previous kernel. If I open up an xterm in X, su to root and
> 'reboot' (or 'shutdown -r now') I instantly get a blue screen that
> persists until the box actually reboots.

Pavel, is this a known issue or should Jesper bisect?

> With previous kernels (all that I can remember, latest tested being
> 2.6.18-git15 (then I jumped from -git15 to -git21)) what happened was
> that X would die and I would be returned to text mode so that I could
> actually see all the shutdown messages from my init scripts (which is
> very nice).
> 
> I don't really know what info would be relevant to provide regarding
> this issue, so please ask for any info you need.
> 
> I can start testing kernels between 2.6.18-git15 and 2.6.18-git21
> and/or  doing git bisects if anyone thinks it will be useful. If you
> want that, please speak up, since I would rather not build and
> test-boot a lot of kernels for no reason if nobody wants the info. But
> if it will be useful I'll be happy to do it.
> 
> Anyway, there's a bug somewhere, let's squash it ;-)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

