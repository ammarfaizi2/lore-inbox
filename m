Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312996AbSDEP0d>; Fri, 5 Apr 2002 10:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312997AbSDEP0O>; Fri, 5 Apr 2002 10:26:14 -0500
Received: from Expansa.sns.it ([192.167.206.189]:3081 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S312996AbSDEP0I>;
	Fri, 5 Apr 2002 10:26:08 -0500
Date: Fri, 5 Apr 2002 17:26:03 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Udo A. Steinberg" <reality@delusion.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Busy buffers in invalidate
In-Reply-To: <3CAD91D7.53D03FBC@delusion.de>
Message-ID: <Pine.LNX.4.44.0204051725240.15574-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you using LVM.
if you get thiose message running vgscan -ay, then
upgrade your LVM tools, and it will disappear


On Fri, 5 Apr 2002, Udo A. Steinberg wrote:

>
> Hello,
>
> With 2.4.18 we recently get a lot of the following in the kernel log:
>
> invalidate: busy buffer
>
> Something to worry about?
>
>
>
> -Udo.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

