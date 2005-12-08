Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVLHMVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVLHMVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 07:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVLHMVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 07:21:43 -0500
Received: from witte.sonytel.be ([80.88.33.193]:51927 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750978AbVLHMVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 07:21:43 -0500
Date: Thu, 8 Dec 2005 13:19:02 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michele <vo.sinh@gmail.com>
cc: Denis Vlasenko <vda@ilport.com.ua>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
In-Reply-To: <f0cc38560512071322m1d370589vd9f8a7684fa2ee1d@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0512081144010.27563@pademelon.sonytel.be>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
 <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random>
 <200512061426.37287.vda@ilport.com.ua> <Pine.LNX.4.62.0512072109360.24915@pademelon.sonytel.be>
 <f0cc38560512071322m1d370589vd9f8a7684fa2ee1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Michele wrote:
> On 12/7/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, 6 Dec 2005, Denis Vlasenko wrote:
> > > On Tuesday 06 December 2005 03:18, Andrea Arcangeli wrote:
> > > > On Mon, Dec 05, 2005 at 04:18:51AM -0800, William Lee Irwin III wrote:
> > > > > The December 6 event is extraordinarily unlikely. What's vastly more
> > > > > likely is consistent "erosion" over time. First the 3D video
> > drivers,
> > > > > then the wireless network drivers, then the fakeraid drivers, and so
> > on.
> > > >
> > > > I agree about the erosion.
> > > >
> > > > I am convinced that the only way to stop the erosion is to totally
> > stop
> > > > buying hardware that has only binary only drivers (unless you buy it
> > to
> > > > create an open source driver or to reverse engineer the binary only
> > > > driver of course! ;).
> > >
> > > I'm afraid there is not enough Linux users in desktop/laptop market
> > > for vendors to notice.
> > >
> > > How about refusing binary-only modules instead? I mean, maybe
> >
> > You mean, call panic() if module license not acceptable? Nice!
> 
> This can only be defined a GPL-integralist approach. You are ignoring closed
> SDK used by almost every one who uses linux on embedded platforms...from
> Linksys routers and access points to media stations to STB with hardware a/v
> decoders. You cant really think linux could influence nearly the whole IT
> market, especially if they make money selling closed source SDK.

If you post in HTML, you're message will never make it to the list.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
