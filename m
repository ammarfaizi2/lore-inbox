Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRKDSmY>; Sun, 4 Nov 2001 13:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281112AbRKDSmT>; Sun, 4 Nov 2001 13:42:19 -0500
Received: from Expansa.sns.it ([192.167.206.189]:45326 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S281108AbRKDSmK>;
	Sun, 4 Nov 2001 13:42:10 -0500
Date: Sun, 4 Nov 2001 19:41:53 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <jarboui@laas.fr>
cc: Ted Deppner <ted@psyber.com>, Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <3BE52ECB.DFE7B040@laas.fr>
Message-ID: <Pine.LNX.4.33.0111041940220.30596-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most of us just developed their own stress test, depending on what they do
need.
Then many use dbench, cerberus and so on.

I would suggest you to start with cerberus.


Luigi


On Sun, 4 Nov 2001, Tahar wrote:

>
> > Yes it would.  It would be a better idea if everyone (including you and
> > me) stress test those pre and final kernels too.
>
> Just a newbie question: where can we find such stress tests, and what
> are the kernel parts targeted by these tests ?
>
> Thanks,
>
> Tahar
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

