Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271018AbRH1NxY>; Tue, 28 Aug 2001 09:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271017AbRH1NxO>; Tue, 28 Aug 2001 09:53:14 -0400
Received: from Expansa.sns.it ([192.167.206.189]:9738 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S271005AbRH1Nw7>;
	Tue, 28 Aug 2001 09:52:59 -0400
Date: Tue, 28 Aug 2001 15:53:05 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Patrick Allaire <pallaire@gameloft.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to disable blanking of the screen in the kernel ?
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB84041F9D2F@srvmail-mtl.ubisoft.qc.ca>
Message-ID: <Pine.LNX.4.33.0108281551460.3378-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with older kernels 2.0 you could find the source fora nice program called
setvesablank, but i think also setterm could fit your needs

On Mon, 27 Aug 2001, Patrick Allaire wrote:

>
> Hi,
>
> I am on a 2.2.19 kernel. I am doing an embedded box and I want to disable
> the console blanking ... how can I do that ? I dont have apm support in the
> kernel. there is no X on the box ...
>
> thank you
>
> Patrick Allaire
> mailto:pallaire@gameloft.com
> If you can see it, but it's not there, it's virtual.
> If you can't see it, but it is there, it's hidden.
> It you can't see it and it isn't there, it's gone.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

