Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281795AbRK0RjZ>; Tue, 27 Nov 2001 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRK0RjP>; Tue, 27 Nov 2001 12:39:15 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:5805 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S281795AbRK0RjA>; Tue, 27 Nov 2001 12:39:00 -0500
Message-ID: <3C03CFA7.3E824AE7@kegel.com>
Date: Tue, 27 Nov 2001 09:38:47 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
In-Reply-To: <3C03CC6C.DD03CDDE@kegel.com> <3C03CF2A.5070307@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

François Cami wrote:
> 
> Dan Kegel wrote:
> 
> > 2.4.x should continue to use -preY.
> > There's no need for a -rcY as some have suggested.
> > All we need to do to avoid messes like the 2.4.15 debacle
> > is to insist that a 2.4.X-preY should not be
> > released as final 2.4.X until the pre's been out for a week,
> > and there should never be any changes introduced into a final
> > that didn't cook for a week as a pre.
> 
> I don't see the difference between a -rc that has cooked for a week,
> and a -pre that has cooked for a week, except that -rc sounds more
> like "this is *maybe* the next stable kernel", whereas -pre still
> sounds "beta".

The difference between "this is *maybe* the next stable kernel"
and "just another beta" is very slippery.  I don't object
to the -rc idea, but I don't think it's as valuable as all that.

> That said, I think the week long delay is a *good* idea.

It's the key to avoiding bad releases.
- Dan
