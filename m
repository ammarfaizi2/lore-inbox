Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWEARrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWEARrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWEARrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:47:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:62451 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932181AbWEARrA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:47:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tnReZzZB0s0iWRTaPySRAxE9vtEbYq3Ie5gNjg2SDensMy6/imgpio4X8ll+d8nIWh3+8kUuKcUEHiK9ax5iQqo51qglMcNw24jxrHRaUllyE8F2mD5i07FAYrWCoGBlvl75y2q7r6ZdWw+AjHks97r7KHo1EJPIPHG7lbDePoo=
Message-ID: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com>
Date: Mon, 1 May 2006 13:46:50 -0400
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Compiling C++ modules
Cc: "Avi Kivity" <avi@argo.co.il>, "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Martin Mares" <mj@ucw.cz>, "Davi Arnaut" <davi.lkml@gmail.com>,
       "Willy Tarreau" <willy@w.ods.org>, "Denis Vlasenko" <vda@ilport.com.ua>,
       dtor_core@ameritech.net, "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0604281309250.7998@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <200604271810.07575.vda@ilport.com.ua>
	 <20060427201531.GH13027@w.ods.org>
	 <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
	 <4451E185.9030107@argo.co.il>
	 <mj+md-20060428.105455.7620.atrey@ucw.cz>
	 <4451FCCC.4010006@argo.co.il>
	 <Pine.LNX.4.61.0604281755360.9011@yvahk01.tjqt.qr>
	 <44524A8A.3060308@argo.co.il>
	 <Pine.LNX.4.61.0604281309250.7998@chaos.analogic.com>
X-Google-Sender-Auth: 9fff5c2ab69f791f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Fri, 28 Apr 2006, Avi Kivity wrote:
> >
> > If your time is bounded, your Python code might be running while you're
> > still typing in your C code, you're be profiling and making changes to
> > the alghorithm in Python while hunting for that mysterious segmentation
> > fault in C (thank goodness for valgrind), and adding multithreading to
> > the third and final version of your Python code while debating whether
> > to buy more memory or sit down and chase that memory leak.
> >
> > Developer performance equates to runtime performance.
> >
>
> Read what you wrote! It's absolutely, incredibly stupid!
>
> The cost in developer time is borne once. The cost of performance
> is borne every time you run the application.

The cost in developer time is borne every time someone needs to modify the code.

Dave
