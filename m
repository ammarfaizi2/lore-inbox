Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281716AbRKZO7L>; Mon, 26 Nov 2001 09:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281727AbRKZO7F>; Mon, 26 Nov 2001 09:59:05 -0500
Received: from smtp.intrex.net ([209.42.192.250]:7431 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S281716AbRKZO5M>;
	Mon, 26 Nov 2001 09:57:12 -0500
Date: Mon, 26 Nov 2001 09:58:19 -0500
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
Message-ID: <20011126095819.B1324@tricia.dyndns.org>
In-Reply-To: <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com> <Pine.LNX.4.33L.0111260857150.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0111260857150.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Mon, Nov 26, 2001 at 08:59:01AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 08:59:01AM -0200, Rik van Riel wrote:
> On Sun, 25 Nov 2001, Linus Torvalds wrote:
> > But you also have to realize that "fewer fundamental changes" is a
> > mark of a system that isn't evolving as quickly, and that is reaching
> > middle age. We are probably not quite there yet ;)
> 
> Doesn't mean we need to get _all_ our TODO items done in
> 2.5.  I really don't see what's wrong with doing only a
> few in 2.5 and delaying the rest for 2.7, especially not
> when both 2.5 and 2.7 happen quickly ;)

On the other hand, I dont think you want major number releases of stable
kernels happening too quickly either.  For people who really care about
stability, moving from 2.2 to 2.4 is a big deal.  I dont think we really
want people to think that they need to do that kind of thing once a year
even if we could manage to get our development cycle shortened that much.

Thanks,

Jim
