Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbRETDlP>; Sat, 19 May 2001 23:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbRETDlF>; Sat, 19 May 2001 23:41:05 -0400
Received: from www.wen-online.de ([212.223.88.39]:54797 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261402AbRETDky>;
	Sat, 19 May 2001 23:40:54 -0400
Date: Sun, 20 May 2001 05:40:28 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <200105200225107.SM01044@paloma16.e0k.nbg-hannover.de>
Message-ID: <Pine.LNX.4.33.0105200537270.488-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Dieter Nützel wrote:

> > > Three back to back make -j 30 runs for three different kernels.
> > > Swap cache numbers are taken immediately after last completion.
> >
> > The performance increase is nice, though.  Do you see similar
> > changes in different kinds of workloads ?
>
> I you have a patch against 2.4.4-ac11 I will do some tests with some
> (interactive) 3D apps.

I don't have an ac kernel resident atm, but since Alan merged here
very recently, it will probably go in ok.  If not, just holler and
I'll download ac11 and make you a clean patch.

	-Mike

