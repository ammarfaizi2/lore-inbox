Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVCYBMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVCYBMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVCYBK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:10:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27409 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261359AbVCYBIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:08:36 -0500
Date: Fri, 25 Mar 2005 02:08:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ravinandan Arakali <ravinandan.arakali@neterion.com>
Cc: linux-kernel@vger.kernel.org,
       "Leonid. Grossman (E-mail)" <leonid.grossman@neterion.com>
Subject: Re: Problem applying latest 2.6 kernel prepatch(2.6.12-rc1)
Message-ID: <20050325010828.GQ3966@stusta.de>
References: <004001c530d4$034e99d0$3a10100a@pc.s2io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004001c530d4$034e99d0$3a10100a@pc.s2io.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 04:45:58PM -0800, Ravinandan Arakali wrote:
> Hi,
> I am trying to submit patches to our driver in the kernel. Since I need a
> copy of latest kernel
> for this, I installed the latest stable version(2.6.5.11). When I apply the
> latest prepatch (2.6.12-rc1)
> on top of this, I have the following problems:
>...
> Has anybody else seen this problem or am I missing something ?

The 2.6.12-rc1 patch is against 2.6.11, not against 2.6.11.5 .

> Thanks,
> Ravi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

