Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277363AbRJZCxa>; Thu, 25 Oct 2001 22:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277366AbRJZCxT>; Thu, 25 Oct 2001 22:53:19 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:23307 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S277363AbRJZCxE>; Thu, 25 Oct 2001 22:53:04 -0400
Date: Thu, 25 Oct 2001 20:56:11 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, ch@westend.com, harlan@artselect.com,
        linux-kernel@vger.kernel.org
Subject: Re: SCSI tape crashes
Message-ID: <20011025205611.A14207@vger.timpanogas.org>
In-Reply-To: <20011025193248.J4795@suse.de> <20011025.172541.102577469.davem@redhat.com> <20011025192648.A13819@vger.timpanogas.org> <20011025.183248.70225421.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011025.183248.70225421.davem@redhat.com>; from davem@redhat.com on Thu, Oct 25, 2001 at 06:32:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David,

Thanks.  I'll wait to hear from Kai since it looks like something
related to his code.  I did find the patch, but was using mutt,
and you were correct, it was attached at the end of the email.

:-)

Jeff


On Thu, Oct 25, 2001 at 06:32:48PM -0700, David S. Miller wrote:
>    From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
>    Date: Thu, 25 Oct 2001 19:26:48 -0700
>    
>    Is this waht's causing the earlier bug I reported in 2.4.10?  If so 
>    where is this patch so I can see if it fixes the problem.
>    
> The patch was in the email, can't you read? :-)
> (You even quoted the patch in your reply!)
> 
> Anyways, my patch isn't relevant to your problem since the
> bug I am fixing only can exist in 2.4.13 and later kernels.
> Sorry.
> 
>    
>    On Thu, Oct 25, 2001 at 05:25:41PM -0700, David S. Miller wrote:
>    > Can people try out this patch?  I believe this will fix the bug.
>    > 
>    > --- drivers/scsi/st.c.~1~	Sun Oct 21 02:47:53 2001
>    > +++ drivers/scsi/st.c	Thu Oct 25 17:23:45 2001
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com
