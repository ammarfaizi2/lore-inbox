Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVKGNhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVKGNhw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 08:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVKGNhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 08:37:52 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:28782 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932482AbVKGNhw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 08:37:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ds4atkwF5Ie6wNC5yNSdajUhzZ1fuyBSm/PECO5PoD6rhC+Huz+N95PBvacQurGs3nqDk5Qwg30Pf4EeKWgWcbNGGlTSBNaTUPlLvwMIfGnWF8xAth5pVa7Z0ZN56J48twlXqvcv18PryJFyNljEGqXVNFKJeAPx51c/5Xs/3o8=
Message-ID: <4d8e3fd30511070537g36f3d35fu2791e95736b8326a@mail.gmail.com>
Date: Mon, 7 Nov 2005 14:37:51 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: Re: Which version of 2.6.11 is most stable
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B13B2BF@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3AEC1E10243A314391FE9C01CD65429B13B2BF@mail.esn.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
>
> Dear Adrian,
>
> Thanks for the information.
> Also Can you please give inputs regarding.....
>
> I have an existing Linux 2.6.11 BSP for an AMD GX processor.
> What would it take me to port the complete BSP to 2.6.12 kernel?
> Can I prefer to work on 2.6.11 kernel which makes me get the system up in no time without any changes made?
> I guess 2.6.11 kernel will work with just a recompilation over 2.6.11.12 kernel.
>
> An inquisitive question about Linux kernels versioning ...
> How do 2.6.(x).1 and 2.6.(x).12 kernels vary?

I think this link could be usefull for you:
http://www.technologynews.altervista.org/index.php?mod=read&id=1130758467

Sorry for the poor formatting, I'm looking for a better hosting for
the document.

--
Paolo
