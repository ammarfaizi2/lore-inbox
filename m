Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUIJLym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUIJLym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUIJLym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:54:42 -0400
Received: from [213.91.207.82] ([213.91.207.82]:31105 "EHLO adsl.nucleusys.com")
	by vger.kernel.org with ESMTP id S265996AbUIJLyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:54:38 -0400
Date: Fri, 10 Sep 2004 14:54:32 +0300 (EEST)
From: Petko Manolov <petkan@nucleusys.com>
To: Eric Valette <eric.valette@free.fr>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver : fixed
In-Reply-To: <41418A90.5050303@free.fr>
Message-ID: <Pine.LNX.4.61.0409101450010.22115@bender.nucleusys.com>
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr>
 <20040909152454.14f7ebc9.akpm@osdl.org> <20040909223605.GA17655@kroah.com>
 <Pine.LNX.4.61.0409101212420.22115@bender.nucleusys.com> <41418A90.5050303@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Eric Valette wrote:

> Petko Manolov wrote:
>
> I never saw traces showing the card should be resetted. It hung occasionnaly 
> in the past but did not know who to really blame (USB vs drivers). It is now

Well, i haven't touched anything major in many many months. :-)

> working well for quite a long time now allthough I periodically transfers 
> more than 100mb via ftp...

That is good news, although many other people have made worse reports in 
the past.

> I'm not sure 2.6.9-rcx-mmx will provide valuable data, we will probably have 
> to wait until distro incoporates this code to get some reasonnable hints... 
> Do you have some well known driver users you could ping to get feedback more 
> quickly?

None that i am aware of.

> Anyway, you are aware of the problem and I know how to fix my problem so all 
> is fine.

All right - lets wait for a little while and see what sort info we'll get. 
Then we'll decide accordingly.


 		Petko
