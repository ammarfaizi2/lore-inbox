Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRJ2TdQ>; Mon, 29 Oct 2001 14:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279406AbRJ2TdG>; Mon, 29 Oct 2001 14:33:06 -0500
Received: from theuw.net ([209.23.48.158]:43738 "HELO narboza.theuw.net")
	by vger.kernel.org with SMTP id <S279403AbRJ2TdC>;
	Mon, 29 Oct 2001 14:33:02 -0500
Date: Mon, 29 Oct 2001 14:33:38 -0500 (EST)
From: <lung@theuw.net>
To: Justin Mierta <Crazed_Cowboy@stones.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <hahn@physics.mcmaster.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ECS k7s5a motherboard doesnt work
In-Reply-To: <3BDD7164.8080401@stones.com>
Message-ID: <Pine.LNX.4.33.0110291427170.26544-100000@narboza.theuw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had started a similar thread last week:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0198.html


There is clearly something wrong with the sis ide driver.  I've lost years
of information due to backups also being corrupt.  I'll hopefully be
testing a patch in the next day or two from Andre.

Reading your previous posts, I'd still have to agree with Alan that
have something else going wrong.  I've had similar problems where things
have worked in windows, but then not even being able to install Linux.
The results problems have ended up being bad ram and inadequate cooling.


On Mon, 29 Oct 2001, Justin Mierta wrote:

> well, i dont have a floppy drive, so that test is a little difficult to
> do, but i threw some ram in there that i have used in linux before, and
> i still had the slew of ide error messages.  and this harddrive has
> worked in linux before.  i'm getting more and more convinced its an ide
> controller +linux issue.
>
> plus, i just discovered this:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0198.html
>
> which really points to ide controller and linux not fighting nicely
> together, altho the thread doesnt really point towards a solution.
>
> justin
>
>
> Alan Cox wrote:
>
> >>well, i've been using it in win98 (unfortunately) and it works
> >>perfectly.  i havent even had it crash at all.  so i doubt its a
> >>hardware thing...
> >>
> >
> >That proves absolutely nothing. Win98 stresses the system differently to
> >Linux. Run test tools like memtest86 on it
> >
>
>
>
>

