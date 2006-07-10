Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWGJM3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWGJM3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWGJM3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:29:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:60960 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964880AbWGJM3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:29:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j5uJB1Z5StaXtiLjBI1Ai1VnzGwoR7/WdLd65LBR0NEbgMkPYAL+RR7CxJHATRJH+3YDO8Ur+48LAR4V5E5j4FrqSCrU4IhX7LG9xeGsdwjWaJBcnp5vfayDYjwNIIYGsyXGfuke3PR0QiP/HimHXwD4NlKG6q3D6/XRLxZKyjE=
Message-ID: <c526a04b0607100529p7626c50as4952fcbaf9896a97@mail.gmail.com>
Date: Mon, 10 Jul 2006 13:29:40 +0100
From: "Adam Henley" <adamazing@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH 2.6.18-rc1 1/1] arch/x86-64: A few trivial spelling and grammar fixes
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <200607100204.07517.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c526a04b0607081027j62887e9bi5a3b93fa4606e003@mail.gmail.com>
	 <1152381894.27368.30.camel@localhost.localdomain>
	 <c526a04b0607081150s54516470p1d1b1726dd7d9675@mail.gmail.com>
	 <200607100204.07517.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Andi Kleen <ak@suse.de> wrote:
> On Saturday 08 July 2006 20:50, Adam Henley wrote:
> > Edited patch.
>
> What edited?
>
> The white space seems worse than before. I already have the previous patch
> now.
>
> Also when you resubmit a patch please always add a complete changelog
>
> -Andi
>

Apologies Andi, white-space munging is probably the fault of gmail,
despite using plain text only, I'll try and use Thunderbird from now
on. The changes to the patch were pursuant to Alan's suggestions:

On 08/07/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Sad, 2006-07-08 am 18:27 +0100, ysgrifennodd Adam Henley:
> > -      * have much chances to find a place in the lower 4GB of memory.
> > +      * have much chance of finding a place in the lower 4GB of memory.
> >        * Unfortunately we cannot move it up because that would make the
> >        * IOMMU useless.
>
> OK (just s/chance/chance/ is enough)
>
>   <snip>
>
> > -      * all of that that no need to invent something new.
> > +      * all of that, no need to invent something new.
>
> Yes (or that. There is no need)
>
> Alan
>
>

Would you like me to resubmit the patch with a complete changelog and
correct whitespace? Sorry for wasting your time over what should have
been such a simple patch.

Thanks,

-adam
