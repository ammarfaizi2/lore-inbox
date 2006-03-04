Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWCDN1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWCDN1t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 08:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWCDN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 08:27:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60432 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751109AbWCDN1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 08:27:49 -0500
Date: Sat, 4 Mar 2006 14:27:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
       Brian Marete <bgmarete@gmail.com>, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] 2.6.16-rc5: known regressions
Message-ID: <20060304132748.GW9295@stusta.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227061354.GO3674@stusta.de> <1141308011.5884.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141308011.5884.5.camel@localhost>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 11:00:11AM -0300, Mauro Carvalho Chehab wrote:
> 
> > Subject    : Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko
> > References : http://lkml.org/lkml/2006/2/20/122
> > Submitter  : Brian Marete <bgmarete@gmail.com>
> > Status     : unknown
> 
> This is not a regression, since the user is not configuring saa7134 with
> the right card. 

Thanks for this information.

The Oops is still a problem that should IMHO be fixed, but I removed 
this issue from my regressions list.

> Cheers, 
> Mauro.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

