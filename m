Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVKISw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVKISw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVKISw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:52:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59666 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965025AbVKISwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:52:24 -0500
Date: Wed, 9 Nov 2005 19:52:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Willy TARREAU <willy@w.ods.org>
Subject: Re: Linux 2.4.32-rc3
Message-ID: <20051109185223.GA4047@stusta.de>
References: <20051109133216.GA9183@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109133216.GA9183@logos.cnet>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 11:32:16AM -0200, Marcelo Tosatti wrote:

> Hi,

Hi Marcelo,

> Two small issues showed up, 
> 
> - IPVS refcont leak 
> - unpriviledged virtual terminal ioctls should be allowed 
> to read function keys
> 
> So here goes -rc3.
> 
> Attaching the full changelog since this is probably the last -rc
> release.
>...

If there will be one more -rc, could you include my airo_cs fix?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

