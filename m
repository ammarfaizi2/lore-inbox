Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVCLLdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVCLLdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVCLLcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:32:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48138 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261566AbVCLLbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:31:44 -0500
Date: Sat, 12 Mar 2005 12:31:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, mpt_linux_developer@lsil.com,
       linux-kernel@vger.kernel.org,
       "Shirron, Stephen" <Stephen.Shirron@lsil.com>
Subject: Re: 2.6: unused code under drivers/message/fusion/
Message-ID: <20050312113142.GB3156@stusta.de>
References: <91888D455306F94EBD4D168954A9457C2D1E91@nacos172.co.lsil.com> <4191CD47.1000205@vlnb.net> <20041110094041.GI4089@stusta.de> <4191E657.1030409@vlnb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4191E657.1030409@vlnb.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 12:58:47PM +0300, Vladislav Bolkhovitin wrote:
> Adrian Bunk wrote:
> >On Wed, Nov 10, 2004 at 11:11:51AM +0300, Vladislav Bolkhovitin wrote:
> >
> >>Moore, Eric Dean wrote:
> >>
> >>>We need to hold off on this change. Yes, there are 
> >>>customers of LSI Logic using mptstm.c, as
> >>>part of the target-mode drivers.  
> >>>
> >>>The proposed generic target mode drivers proposal is yet part
> >>>of the kernel.  
> >>>http://scst.sourceforge.net/
> >>>We are looking into supporting this once its available.
> >>
> >>Well, SCST is already available, stable and useful. People use it 
> >>without considerable problems, except with inconvenient LUNs management, 
> >>which we are going to fix in the next version. I don't expect it will be 
> >>considering for the kernel inclusion at least until 2.7. So, you can 
> >>start supporting it right now :-).
> >
> >
> >With the current kernel development model, there is no 2.7 planned for 
> >the next years.
> >
> >Linus and Andrew believe 6 was an odd number, so you could submit your 
> >code now. [1]
> 
> OK, I'll prepare the next version as the kernel patch.

Any news regarding this?

> Thanks,
> Vlad

Thanks
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

