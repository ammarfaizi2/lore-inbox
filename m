Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSGIToD>; Tue, 9 Jul 2002 15:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGIToC>; Tue, 9 Jul 2002 15:44:02 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:23565 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317471AbSGIToB>; Tue, 9 Jul 2002 15:44:01 -0400
Subject: how to debug it?
From: Michael Gruner <stockraser@yahoo.de>
To: Joseph Pingenot <trelane@digitasaru.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020709133606.A8202@ksu.edu>
References: <1026193021.1076.29.camel@highflyer>
	<200207091227.15957.bernd-schubert@web.de>
	<1026232702.757.9.camel@highflyer>  <20020709133606.A8202@ksu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1026243598.757.56.camel@highflyer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Jul 2002 21:40:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >ok, did it as you say: in the BIOS I switched to Vsync/blank screen.
> >Let's see what happens.
> >BTW: My graphics card isn't a nvidia as many of you suggested but an ATI
> >Rage pro (what did you wrote Bernd? ;-) ).
> >Another interesting thing I got back in mind today was: one day my XMMS
> >played a mp3 song and I switched to console (oooops...you know what
> >happend) but the song kept on playing in a loop that was some
> >milliseconds until I powered the box off. I don't know what to think
> >about that.
> 
> I've seen the same thing on my ATI XPert@Play (Rage Pro chipset).  At 
>   2.4.17, it was a risky proposition to switch between X and a text VC.
>   It's better in 2.4.18, although not much (I believe.  I may be wrong).
>   I have happend upon a situation a number of times where, when switching
>   from X to a text VC, the machine "locks up", but CTRL-F7 (the X VC) will
>   get me back to a working X login screen (KDM), at least for a while.  If
>   I keep trying to switch to a text VC (which never works), it eventually
>   fully locks up, to the point where I have to pull the plug, since the on
>   switch is non-responsive.  If I tell it to shut down, it gets *most* of
>   the way through before carping out and locking up fully.
> I don't *believe* I've seen this in 2.5.x, although I may be wrong.
> 
Do you think it would be a good idea to get it out of the stable tree?
Or is it better to try to live with it and wait for getting 2.5 the
stable tree?

Is there a howto to get this debugged? Looking into /var/log/messages
there are no messages that could point out that bad thing.

michael

-- 
Windmuehlenweg 22 07907 Schleiz
mobil: +491628955029
e-Mail: Michael.Gruner@fh-hof.de


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

