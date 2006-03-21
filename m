Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWCUKxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWCUKxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWCUKxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:53:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39428 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965024AbWCUKxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:53:39 -0500
Date: Tue, 21 Mar 2006 11:53:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, tiwai@suse.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: unresolved emu10k1 synth symbols.
Message-ID: <20060321105332.GA3865@stusta.de>
References: <20060321054634.GA5122@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321054634.GA5122@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 12:46:34AM -0500, Dave Jones wrote:
>...
> This looks like it can't possibly work, unless I change
> CONFIG_SND_EMU10K1 to =y.  Is exporting a symbol from one
> module to another actually supposed to work?
>...

How could e.g. CONFIG_SCSI=m or CONFIG_USB=m do anything useful if it 
wasn't?

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

