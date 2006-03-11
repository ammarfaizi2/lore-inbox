Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWCKQMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWCKQMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 11:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWCKQMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 11:12:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751213AbWCKQMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 11:12:14 -0500
Date: Sat, 11 Mar 2006 17:12:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/media/dvb/bt8xx/dst_ca.c: fix 2 memory leaks
Message-ID: <20060311161213.GS21864@stusta.de>
References: <20060311151142.GP21864@stusta.de> <4412F27E.5090705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4412F27E.5090705@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 07:53:34PM +0400, Manu Abraham wrote:
> 
> Yeah, it is better indeed. Would you mind if i schedule this for a 
> little while later, since i have a couple of other fixes/additions as well ?

There's no need to hurry since the whole problem is only a small memory 
leak in a very unlikely case.

> Thanks,
> Manu

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

