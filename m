Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVCESoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVCESoH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCESiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:38:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:9451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261277AbVCESeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:34:50 -0500
Message-ID: <4229F8F6.1090700@osdl.org>
Date: Sat, 05 Mar 2005 10:22:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050305095139.A26541@flint.arm.linux.org.uk> <4229EA0A.8010608@pobox.com> <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 5 Mar 2005, Jeff Garzik wrote:
> 
>>Yup, BK could definitely handle that...
> 
> 
> However, it's also true that the thing BK is _worst_ at is cherry-picking 
> things, and having a collection of stuff where somebody may end up vetoing 
> one patch and saying "remove that one".
> 
> So it's entirely possible that the proper tool to use for the first level 
> is not BK at all, but the evolved patch-scripts that Andrew uses, in other 
> words:
> 
> 	http://savannah.nongnu.org/projects/quilt
> 
> may well be a much better thing to use.
> 
> I love BK, but what BK does well is merging and maintaining trees full of 
> good stuff. What BK sucks at is experimental stuff where you don't know 
> whether something should be eventually used or not.

I almost volunteered (read: suckered) and would use patch-scripts
or quilt to do the job.  It (the tool) seems to be a natural fit
for it (the job).

However, I'm happy with Greg and Chris doing it.  :)   suckers.

-- 
~Randy
