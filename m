Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSFGAwP>; Thu, 6 Jun 2002 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSFGAwK>; Thu, 6 Jun 2002 20:52:10 -0400
Received: from iafilius.xs4all.nl ([213.84.160.212]:3720 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S313181AbSFGAwK>;
	Thu, 6 Jun 2002 20:52:10 -0400
Date: Fri, 7 Jun 2002 02:51:44 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: arjan@sjoerd.sjoerdnet
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Brian J. Conway" <bconway@WPI.EDU>, <linux-kernel@vger.kernel.org>
Subject: Re: Promise Ultra100 hang
In-Reply-To: <1023393812.23008.22.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206070245570.8609-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,


On 6 Jun 2002, Alan Cox wrote:

> On Thu, 2002-06-06 at 19:53, Arjan Filius wrote:
> > Hello Brian,
> >
> > Same issue here, 2.4.18 running fine with my new 160GB maxtor drive on a
> > promise udma100 ide controller, 2.4.19-pre9 hangs on partition check at
> > boot time.
>
> Should be ok in pre10-ac2. I'll push Marcelo the change soon

pre10-ac2 runs fine (promise udma100 issue).

Thanks for the reponse.

>
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

