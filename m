Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424357AbWKPT3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424357AbWKPT3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424369AbWKPT3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:29:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51716 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424357AbWKPT3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:29:41 -0500
Date: Thu, 16 Nov 2006 20:29:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Yitzchak Eidus <ieidus@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changing internal kernel system mechanism in runtime by a module patch
Message-ID: <20061116192936.GF31879@stusta.de>
References: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 09:19:50PM +0200, Yitzchak Eidus wrote:
> is it possible to replace linux kernel internal functions such as
> schdule () to lets say my_schdule ()  in a run time with a module
> patch???
> (so that every call in the kernel to schdule() will go to my_schdule()... ) 
> ???
> 
> i am talking about a clean/standard way to do such thing
> (without overwrite the mem address of the function and replace it in a
> dirty way...)

No.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

