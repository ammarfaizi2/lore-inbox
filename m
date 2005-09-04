Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVIDTdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVIDTdw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 15:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVIDTdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 15:33:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24592 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751042AbVIDTdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 15:33:52 -0400
Date: Sun, 4 Sep 2005 21:33:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bas Westerbaan <bas.westerbaan@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Paul Misner <paul@misner.org>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050904193350.GA3741@stusta.de>
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua> <200509041144.13145.paul@misner.org> <84144f02050904100721d3844d@mail.gmail.com> <6880bed305090410127f82a59f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6880bed305090410127f82a59f@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 07:12:33PM +0200, Bas Westerbaan wrote:
> > Yes you are. You're asking for 4KSTACKS config option to maintained
> > and it is not something you get for free. Besides, if it is indeed
> > ripped out of mainline kernel, you can always keep it a separate patch
> > for ndiswrapper.
> 
> Though 4K stacks are used a lot, they probably aren't used on all
> configurations yet. Other situations may arise where 8K stacks may be
> preferred. It is too early to kill 8K stacks imho.

Please name situations where 8K stacks may be preferred that do not 
involve binary-only modules.

> Bas Westerbaan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

