Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSLBPSb>; Mon, 2 Dec 2002 10:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSLBPSb>; Mon, 2 Dec 2002 10:18:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20169 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262792AbSLBPSa>;
	Mon, 2 Dec 2002 10:18:30 -0500
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: xizard@enib.fr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DEAA671.5090008@enib.fr>
References: <3DEA322B.40204@enib.fr> <1038768875.12518.2.camel@localhost>
	 <3DEAA671.5090008@enib.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1038842693.2897.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 09:24:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-01 at 18:16, XI wrote:
>  
> > 
> >>I think the first thing I should do is to try different kernel version
> >>in order to find when this problem appeared first.
> > 
> > 
> > --The GrandMaster
> > 
> 
> Thanks for the reply,
> 
> I don't think this is the problem, because nothing is plugged into mic 
> or line in; and all settings are set to 0 in aumix except Vol, Pcm and 
> OGain.

It's not so much about what is connected to the devices, as what is
actually going on in the asic on the board. If something were faulty, or
slightly more sensetive than it should be(too high a tolerance), then
you could get this affect. Changing your mixer parameters might show you
the light, er um...let you hear the difference and see if it gets worse
or not. Another thing you could also do, is move the sblive card to a
different slot, if not yet tried. If in too close proximity to the NIC,
it *could* cause this behaviour as well. 

> 
> Xavier
> 
