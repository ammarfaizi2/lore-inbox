Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271214AbRHTOcs>; Mon, 20 Aug 2001 10:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271242AbRHTOck>; Mon, 20 Aug 2001 10:32:40 -0400
Received: from [213.171.56.2] ([213.171.56.2]:33555 "EHLO mail.ixcelerator.com")
	by vger.kernel.org with ESMTP id <S271214AbRHTOcb>;
	Mon, 20 Aug 2001 10:32:31 -0400
Date: Mon, 20 Aug 2001 18:32:39 +0400
From: Oleg Drokin <green@iXcelerator.com>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: green@linuxhacker.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.8-ac7 sound crashes
Message-ID: <20010820183239.A15384@iXcelerator.com>
In-Reply-To: <E15Yq2J-0007mi-00@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Yq2J-0007mi-00@f10.mail.ru>; from _deepfire@mail.ru on Mon, Aug 20, 2001 at 06:28:15PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 20, 2001 at 06:28:15PM +0400, Samium Gromoff wrote:
> >   Can you publish decoded oops?
> >   And can you try 2.4.9 first to check it exhibits >same behaviour?
>     1. quite impossible due to the fact of exceedingly
> high rate at which this trace is running:
>   30 rows/second approx, and the impossibility to
>   switch consoles/use gpm for cut/paste...
I can recommend you to use some kind of serial parallel console.
(I can even borrow you one if you are in Moscow)

>     2. i will, but results - tomorrow (GMT+3), since i`ll leave
>   2.4.9 compilation to night (i tried twice, but failed
>   because of infamous compile errors of ntfs and irda).
Leave out ntfs and irda this time, or apply patches that were already published.

Bye,
    Oleg
