Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbRE2E6y>; Tue, 29 May 2001 00:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbRE2E6o>; Tue, 29 May 2001 00:58:44 -0400
Received: from www.wen-online.de ([212.223.88.39]:20748 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263208AbRE2E63>;
	Tue, 29 May 2001 00:58:29 -0400
Date: Tue, 29 May 2001 06:57:59 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
In-Reply-To: <Pine.LNX.4.21.0105281636160.1261-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105290645410.515-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2001, Marcelo Tosatti wrote:

> On Mon, 28 May 2001, Mike Galbraith wrote:
>
> > On Mon, 28 May 2001, Leeuw van der, Tim wrote:
> >
> > > The VM in 2.4.5 might be largely 'fixed' and I know that the VM changes in
> > > -ac were considered to be but still broken, however for me they worked
> > > better than what is in 2.4.5.
> >
> > The VM changes in 2.4.5 fixed a very serious performance problem.  IMHO,
> > 2.4.5 is a step in the right direction.  (and I hope more steps are in
> > the offing;)
>
> It did not fixed any interactivity problem.

Yes, I know.  I mentioned that interactivity went south here back
when we stopped waiting.  The performance problem I was refering to
was the cache collapsing as soon as you hit a load spike.  You and
Rik killed that longstanding problem.

	-Mike

