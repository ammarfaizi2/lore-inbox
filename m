Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129617AbQKBVK0>; Thu, 2 Nov 2000 16:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129605AbQKBVKQ>; Thu, 2 Nov 2000 16:10:16 -0500
Received: from ra.lineo.com ([204.246.147.10]:10660 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129366AbQKBVKB>;
	Thu, 2 Nov 2000 16:10:01 -0500
Message-ID: <3A01D6D1.44BD66FE@Rikers.org>
Date: Thu, 02 Nov 2000 14:04:17 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <E13rRMc-0001sX-00@the-village.bc.nu>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 02:09:57 PM,
	Serialize complete at 11/02/2000 02:09:57 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Alan Cox wrote:
> 
> > > That need to run Linux - name one ? Why try to solve a problem when it hasn't
> > > happened yet. Let whoever needs to solve it do it.
> >
> > We have proposals here all under NDA. So I won't mention one of them.
> > Perhaps there are some of these folk on the list that would like to
> > comment?
> 
> Then I think it will be up to you to achieve the non gcc build or to teach
> your compiler gcc extensions (which may or may not be easier). The kernel also
> tends to know a few things about how gcc optimises code which shouldn't matter
> if your compiler is good enough to optimise nicely anyway.

This is completely reasonable. I guess what I'm asking is:

How can I insure that the largest possible amount of my efforts benefit
the community at large? Hopefully this will make it easier to move to
C99 or any other future compiler porting project.

> 
> AFAIK the only non gcc port of Linux isnt exactly a port but was ELKS done using
> bcc86 (Bruce Evans compiler)

I have not looked at this project. Thank you for the pointer. I hope to
learn form their experiences.

> 
> Alan

PS, while I'm writing to you. I reread my earlier reply to you and Ben
was right about chewing me out for it. My bad.
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
