Return-Path: <linux-kernel-owner+w=401wt.eu-S965011AbWL1WQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWL1WQO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWL1WQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:16:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1428 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965011AbWL1WQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:16:13 -0500
Date: Thu, 28 Dec 2006 23:16:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
Message-ID: <20061228221616.GI20714@stusta.de>
References: <459069AA.20809@rrz.uni-koeln.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459069AA.20809@rrz.uni-koeln.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2006 at 01:15:38AM +0100, Berthold Cogel wrote:

> Hello!

Hi Berthold!

> 'shutdown -h now' doesn't work for my system (Acer Extensa 3002 WLMi)
> with linux-2.6.20-rc kernels. The system reboots instead.
> I've checked linux-2.6.19.1 with an almost identical .config file
> (differences because of new or changed options). For pre 2.6.20 kernels
> shutdown works for my computer.
>...

Thanks for your report.

Please send:
- the .config for 2.6.20-rc2
- the output of "dmesg -s 1000000" with 2.6.20-rc2
- the output of "dmesg -s 1000000" with 2.6.19

> Regards,
> 
> Berthold Cogel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

