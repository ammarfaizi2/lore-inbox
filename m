Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbULTMuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbULTMuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULTMuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:50:11 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:7341 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S261499AbULTMuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:50:04 -0500
Message-ID: <303550202.05721@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
Date: Mon, 20 Dec 2004 21:43:22 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: Re: About kernel panic!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you mean that there is something wrong with my Kernel Code? So, i have to use a
new kernel code, but i can't understand why.

Thanks and Best,


>From: Nick Piggin <nickpiggin@yahoo.com.au>
>Reply-To: 
>To: Zhenyu Wu <y030729@njupt.edu.cn>
>Subject: Re: About kernel panic!
>Date:Mon, 20 Dec 2004 20:21:23 +1100
>
>Zhenyu Wu wrote:
> > Hello, Everyone,
> > 
> > I think i have met lots of troubles when i am programming in the kernel, so,
i
> > want to get
> > some help.
> > 
> > One of my troubles is that, sometimes, the program can work well, but
sometimes,
> > there are
> > kernel panics. So, does someone else meet such questions, what is the major
> > reasons? From the
> > indication of the log messages, i can find the messages on allocting the
memory, i
> > remember, 
> > i use the kmalloc to do it, but is there something wrong? 
> > 
> 
> Yes, there is something wrong with your kernel code. The oops will
> tell you what went wrong.
> 
> Reading Documentation/oops-tracing.txt is a good start.
> 
> Nick
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


