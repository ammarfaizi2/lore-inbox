Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135252AbRDLS6c>; Thu, 12 Apr 2001 14:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135254AbRDLS6W>; Thu, 12 Apr 2001 14:58:22 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:43282 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135252AbRDLS6P>;
	Thu, 12 Apr 2001 14:58:15 -0400
From: thunder7@xs4all.nl
Date: Thu, 12 Apr 2001 20:53:03 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: [PATCH] matroxfb and mga XF4 driver coexistence...
Message-ID: <20010412205303.A20394@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <3AD5A7C4.D740ED74@neuronet.pitt.edu> <Pine.LNX.4.31.0104120922070.15715-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.31.0104120922070.15715-100000@rc.priv.hereintown.net>; from clubneon@hereintown.net on Thu, Apr 12, 2001 at 09:28:44AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 09:28:44AM -0400, Chris Meadors wrote:
> On Thu, 12 Apr 2001, Rafael E. Herrera wrote:
> > If the problem occurs whithout the frame buffer on, the problem seems to
> > be on the X server.
> 
> Exactly.  That is what I'm saying.  I've seen the problem with the
> returning to VESA text modes from XFree 4.0 anytime I use the hallib, with
> 2.2 and 2.4 kernels.  If I compile an X server without the hallib it's
> fine (G450 users don't have that option, and I like my dual head).
> 
> If X changes the mode upon starting it should put it back when it is done.
> 
Of course, but if we can fix the problem by making the kernel smaller,
what possible motive could you have for opposing it other than 'but it
doesn't solve _my_ problems!' ?

Good luck,
Jurriaan
-- 
HORROR FILM WISDOM:
7. If you're running from the monster, you will most likely trip or
fall. If you are female you can bet on it.
GNU/Linux 2.4.3-ac4 SMP/ReiserFS 2x1743 bogomips load av: 0.03 0.01 0.02
