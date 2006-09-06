Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWIFNk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWIFNk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWIFNk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:40:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59918 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750932AbWIFNjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:39:54 -0400
Date: Wed, 6 Sep 2006 15:39:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olaf@aepfle.de>
Cc: stable@kernel.org, maks@sternwelten.at, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SERIAL] icom: select FW_LOADER
Message-ID: <20060906133944.GP9173@stusta.de>
References: <20060816175350.GA9888@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816175350.GA9888@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:53:50PM +0200, Olaf Hering wrote:
> 
> The icom driver uses request_firmware()
> and thus needs to select FW_LOADER.
>...

Thanks, applied to 2.6.16.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

