Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313291AbSC1XRn>; Thu, 28 Mar 2002 18:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313292AbSC1XRg>; Thu, 28 Mar 2002 18:17:36 -0500
Received: from nat-wohnheime.rz.uni-karlsruhe.de ([193.196.41.250]:23518 "EHLO
	t28a301.tennessee.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S313291AbSC1XR3>; Thu, 28 Mar 2002 18:17:29 -0500
Date: Fri, 29 Mar 2002 00:17:10 +0100 (CET)
From: Stephan Fuhrmann <fury@t28a301.tennessee.uni-karlsruhe.de>
Reply-To: Stephan.Fuhrmann@stud.uni-karlsruhe.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel v2.4.18, faulty virtual mem code?
In-Reply-To: <E16qjM5-0000Dz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0203290014560.3498-100000@t28a301.tennessee.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Alan Cox wrote:

> > I got a small problem while running a game under X11.
> > It looks to me that there is a problem in the virtual
> > memory code.
> > My machine doesn't crash, it just dumps a kernel stack
> > to the console.
>
> Are you using the Nvidia binary only driver ?

Wow, this was fast!!! Thank you!

Yes :((( ... I compiled almost everything myself, but there's still
something Nvidia delivers as object files.
--
Stephan Fuhrmann


