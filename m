Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTAFHbv>; Mon, 6 Jan 2003 02:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTAFHbv>; Mon, 6 Jan 2003 02:31:51 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:34258 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S266257AbTAFHbu>; Mon, 6 Jan 2003 02:31:50 -0500
Subject: Re: Honest does not pay here ...
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Stephen Satchell <list@fluent2.pyramid.net>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.0.9.0.20030105173556.01e30560@fluent2.pyramid.net>
References: <2209530000.1041811301@localhost.localdomain>
	 <Pine.LNX.4.10.10301051223130.421-100000@master.linux-ide.org>
	 <1041805731.1052.4.camel@aurora.localdomain>
	 <2209530000.1041811301@localhost.localdomain>
	 <5.2.0.9.0.20030105173556.01e30560@fluent2.pyramid.net>
Content-Type: text/plain
Organization: 
Message-Id: <1041838816.1045.4.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 02:40:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 20:43, Stephen Satchell wrote:
> As I see it, Andre's problems are a little tougher because there isn't a 
> choice of alternatives to the IP that he incorporates in his product, if 
> I'm reading his contributions correctly.  (I've not followed the arguments 
> closely, so I could very well be in need of disabusement of my incorrect 
> notions.)
> 
> I'm surprised Richard Stallman didn't remind everyone of the thing that 
> started the whole argument for free software:  his inability to drive a 
> laser printer because of closed, unpublished specifications.  I won't put 
> words in his mouth (RMS is more than capable of speaking for himself) but 
> his concern is if the company goes away and there are problems with the 
> binary-only module, then people will be forced to junk the hardware or live 
> with the problems.
> 
> Ok, I'll go back to my hole now.
> 
> Satch

I guess a question then might be this:  Andrea, I understand your stance
of needing to make a decent living and fund development.  I think Satch
has a point about the company going away (or the Bus problem... as in
something happens to you).  Is there any way you can feasibly (legal and
monetary concerns included) do a kind of code escrow so if such happens,
your code becomes GPL/BSD?  

BTW, I may be somewhat out of understanding here.  From what I have been
reading it seems the following is true:

1) Andre is making drivers for hardware or protocols
2) He is making them closed until he recoups his costs (I saw 18 mos
somewhere as the time needed...)
3) He then will open them up

If I am wrong, sorry, but this should say where I am seeing all this
from.

Also, I see the following...

1) The problem lies with him including kernel headers (I didn't think
magic numbers and such were really coverable by copyright... so unless
we are talking macros... where is the problem).
2) Interfaces are reverse engineer-able under US law for
interoperability purposes (DMCA may have muddied this)
3) The Interface calls (sys-calls etc.) are LGPL...

So where is the real problem here?

Trever
--
One O.S. to rule them all, One O.S. to find them. One O.S. to bring them
all and in the darkness bind them.

