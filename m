Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCBTw3>; Fri, 2 Mar 2001 14:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRCBTwU>; Fri, 2 Mar 2001 14:52:20 -0500
Received: from [62.81.160.67] ([62.81.160.67]:21952 "EHLO smtp1.alehop.com")
	by vger.kernel.org with ESMTP id <S129466AbRCBTwE>;
	Fri, 2 Mar 2001 14:52:04 -0500
Date: Fri, 2 Mar 2001 20:26:02 +0000 (WET)
From: Miguel Armas <kuko@ulpgc.es>
To: linux-kernel@vger.kernel.org
Cc: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: kernel 2.4.2 SMP + ATM hangs (fwd)
Message-ID: <Pine.LNX.4.21.0103022025060.6364-100000@mento.ulpgc.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Mar 2001, Mitchell Blank Jr wrote:

> Miguel Armas wrote:
> > A couple days ago we installed a Fore 200E ATM card and after getting the
> > ATM address using ilmid the machine hangs. The kernel still respond to
> > pings, but the userspace is dead.
> > 
> > If we remove SMP support in the kernel everything works fine (but with
> > only one CPU)...
> 
> You probably need the patch that Chas Williams came up with in January.
> I've been meaning to forward it, but I haven't yet.  Please try it and
> see if it fixes your problem.

I just applied the patch and everything works now. Thanks a lot!
 
Salu2!
-- 
------------------------------------
Miguel Armas del Rio <kuko@ulpgc.es>
Division de Comunicaciones (DC)
Universidad de Las Palmas
------------------------------------


