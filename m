Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVHFVcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVHFVcB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 17:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVHFVcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 17:32:00 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:40471 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261274AbVHFVb4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 17:31:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XRgCCXmnHhPA8Ip3kQ99CA/YlOZ9gSuzPJdktY2qb46rVSyXo6BXsRZku0RR5DNoBcSb3Bcmj3Eo03j5n1dMdt0svO4TarVT8mKqKLslaw1/3k/4+4yFbG+tjZslCEMP97+UXWN9jqOqKGMjIhWMoa3irDP0y0jpBHD54QhHbB0=
Message-ID: <5a67a16f05080614317944c976@mail.gmail.com>
Date: Sat, 6 Aug 2005 17:31:55 -0400
From: Athul Acharya <aacharya@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Determining if the current processor is Hyperthreaded
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a67a16f05080506452dcc537c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a67a16f05072909245ae1c44c@mail.gmail.com>
	 <42EFB3BB.1060900@tmr.com> <5a67a16f050802171478233f2f@mail.gmail.com>
	 <5a67a16f05080506452dcc537c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Athul Acharya <aacharya@gmail.com> wrote:
> On 8/2/05, Athul Acharya <aacharya@gmail.com> wrote:
> > That is, I want to know whether the current cpu I (kernel code) am
> > executing on is hyperthreaded, and if so, which logical cpu represents
> > the other thread on chip.
> 
> Trying again, as it seems like a simple thing that really should exist
>  --  is_cpu_hyperthreaded(smp_processor_id()) -- or something similar.
>  Anyone?

Is anyone receiving this?  I should've mentioned in subsequent mails
(I did in the original) that I'm not subscribed so any replies need to
be cc'd to me :)

Athul
