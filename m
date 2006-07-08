Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWGHAAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWGHAAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWGHAAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:00:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19217 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932419AbWGHAAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:00:00 -0400
Date: Sat, 8 Jul 2006 02:00:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: alsa-devel@alsa-project.org, perex@suse.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: OSS driver removal, 2nd round (v2)
Message-ID: <20060708000000.GG26941@stusta.de>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p737j2potzr.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 01:50:00AM +0200, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> > 
> > Q: What about the OSS emulation in ALSA?
> > A: The OSS emulation in ALSA is not affected by my patches
> >    (and it's not in any way scheduled for removal).
> 
> I again object to removing the old ICH sound driver.
> It does the same as the Alsa driver in much less code and is ideal
> for generic monolithic kernels

First of all, if you read my email you'll note that this driver isn't 
currently scheduled for removal.

And more important, your comment is already covered by the other FAQ 
entry in my email:

Q: But OSS is kewl and ALSA sucks!
A: The decision for the OSS->ALSA move was four years ago.
   If ALSA sucks, please help to improve ALSA.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

