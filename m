Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271900AbTGRWj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271914AbTGRWj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:39:26 -0400
Received: from web13305.mail.yahoo.com ([216.136.175.41]:2160 "HELO
	web13305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271900AbTGRWis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:38:48 -0400
Message-ID: <20030718225344.37834.qmail@web13305.mail.yahoo.com>
Date: Fri, 18 Jul 2003 15:53:44 -0700 (PDT)
From: Ronald Jerome <imun1ty@yahoo.com>
Subject: Re: 2.5.72 insmod question
To: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030718073536.5e60cc3d.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I would also mention for the Redhat users
especially redhat v9.0 users to grab the rawhide
versions of the updated modutils and mkinitrd.

Especially if they want to be able to boot kernels 2.4
and 2.5, 2.6 series


I had to reinstall redhat because the rusty mod-utils
alone did not allow the mkinitrd to work for 2.5
kernels.  Had soemone help me do some modification to
mkinitrd to geta good working initrd.

Anhow few things happened and I ended up reinstalling
my redhat v9.0 and this time installed the rawhide
rpm's modutils and mkinitrd.  


--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> On Fri, 18 Jul 2003 13:50:45 +0200 Tomas Szepe
> <szepe@pinerecords.com> wrote:
> 
> | > [rddunlap@osdl.org]
> | > 
> | > And you probably should read over the 2.6
> migration document:
> | >  
> http://www.codemonkey.org.uk/post-halloween-2.5.txt
> | 
> | Wouldn't it be a good idea to print a similar note
> during
> | "make *config" in the 2.6.0-test series?  I mean,
> this must
> | be the 80th or so post of its kind this week.
> 
> Sure, that sounds good to me.  Some way to get that
> message to
> the masses, since putting it in an email signature
> doesn't get
> the message to the right people... :(
> 
> --
> ~Randy
> For Linux-2.6:
> http://www.codemonkey.org.uk/post-halloween-2.5.txt
>   or http://lwn.net/Articles/39901/
>
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
