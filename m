Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313333AbSDGQGm>; Sun, 7 Apr 2002 12:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313334AbSDGQGl>; Sun, 7 Apr 2002 12:06:41 -0400
Received: from Expansa.sns.it ([192.167.206.189]:18699 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S313333AbSDGQGl>;
	Sun, 7 Apr 2002 12:06:41 -0400
Date: Sun, 7 Apr 2002 18:06:26 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Best 2.4 kernel for SPARC?
In-Reply-To: <000701c1dcf8$6d5b61b0$0201a8c0@homer>
Message-ID: <Pine.LNX.4.44.0204071803130.2539-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.18 without problems on ultra2, ultra5 ultra10
E280 E420, so I tested both mono CPU and SMP (till 4 CPUs) systems.
on the ultra2 SMP I tested also the peemptive kernel patch.

So I think you can be quite sure with latest 2.4 kernels.
Another thing is 2.5 kernels, I was not able to use many of them on sparc.

Luigi

On Sat, 6 Apr 2002, Martin Eriksson wrote:

> What is the 2.4 kernel that works best for SPARC?
>
> The machine is a SPARC Ultra 10 3D creator with RedHat 6.2, now running some
> old 2.4 kernel (cannot check right now).
>
> I would also like to test some low-latency stuff if possible, and it is very
> important that rebooting/powering off works 100% as it's an remote machine.
>
> /Martin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

