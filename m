Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129142AbQKBTNq>; Thu, 2 Nov 2000 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKBTNg>; Thu, 2 Nov 2000 14:13:36 -0500
Received: from ra.lineo.com ([204.246.147.10]:65186 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129142AbQKBTNY>;
	Thu, 2 Nov 2000 14:13:24 -0500
Message-ID: <3A01BB7D.B084B66@Rikers.org>
Date: Thu, 02 Nov 2000 12:07:41 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <E13rPhi-0001ng-00@the-village.bc.nu>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 12:13:21 PM,
	Serialize complete at 11/02/2000 12:13:21 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > 1. There are architectures where some other compiler may do better
> > optimizations than gcc. I will cite some examples here, no need to argue
> 
> I think we only care about this when they become free software.

This may be your belief, but I would not choose to enforce it on
everyone. Thank you for you opinion.

> > 2. There are architectures where gcc is not yet available, but vendor C
> > compilers are.
> 
> That need to run Linux - name one ? Why try to solve a problem when it hasn't
> happened yet. Let whoever needs to solve it do it.

We have proposals here all under NDA. So I won't mention one of them.
Perhaps there are some of these folk on the list that would like to
comment?

> 
> Alan

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
