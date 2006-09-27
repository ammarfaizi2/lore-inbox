Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWI0RkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWI0RkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWI0RkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:40:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:9641 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030437AbWI0RkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:40:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dHin7LZCJCrdjpXJtRLOhrDzwLC59cc9kW8P2kURQfqST6cYYiCbA0sxNe/hHODcf++zIIctE/qJZ0teEc8dS+Vq8go9ZB2J08A/cjwOJ0LP2Oj20jpcdhPEMusXmjs2ijoA+KvXWQF4uHnh2kFoTyAUIv4F6ZyLn5O/Hqh0GSo=
Message-ID: <e4891d4c0609271040u44576064x2a171160d068cd55@mail.gmail.com>
Date: Wed, 27 Sep 2006 12:40:04 -0500
From: "Jonathan Stewart" <jonathan.stewart@gmail.com>
To: "Shriramana Sharma" <samjnaa@gmail.com>
Subject: Re: Improvements in 2.6.18 will help SATA?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609261046.35391.samjnaa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609261046.35391.samjnaa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shriramana,

I am not a developer, just a user like yourself.  However, i think i
can answer your question in a general sense.

First, your question was if 2.6.18 would have improvements over
2.6.15.  The answer is: yes.  The newest kernel versions are almost
always better than the previous versions.  If they are not better,
this is called a 'regression' and treated as a bug.

So, in the spirit of community testing, i'd suggest that you perform
some repeatable test with your current kernel, then upgrade, and test
again to see if you can observe improvements. Providing this
information to the kernel mailing list might even be useful to some
developers.

And also, no, this is not OT.  If you're talking about the linux
kernel (which you are) then you're most definately on-topic.

Cheers,
Jonathan

On 9/26/06, Shriramana Sharma <samjnaa@gmail.com> wrote:
> I'm an end user, not a developer. From:
>
> http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.18
>
> I see that a lot of the changes are related to SATA. I have a Seagate SATA HDD
> as my one and only HDD so if I will really be benefitting performance-wise
> from the new features or improvements, then I will install 2.6.18 over
> 2.6.15. So please tell me as I am not able to decipher for myself, whether
> these improvements will lead to better performance, efficiency, speed or
> something like that on my SATA HDD.
>
> Please don't be harsh with me if this question is way OT for this list. I
> thought only the developers can answer such a question so I asked here. I'm
> sincerely sorry if I am bothering anyone.
>
> Please cc me as I am not on the list.
>
> --
>
> Shriramana Sharma
> Linux user #395953 using Kubuntu 6.06.1
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
     Jonathan
