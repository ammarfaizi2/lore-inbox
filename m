Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292248AbSBOWqv>; Fri, 15 Feb 2002 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292254AbSBOWqo>; Fri, 15 Feb 2002 17:46:44 -0500
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:42696 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292248AbSBOWnV>; Fri, 15 Feb 2002 17:43:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Disgusted with kbuild developers
Date: Fri, 15 Feb 2002 17:44:09 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Dave Jones <davej@suse.de>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020215155946.B14083@thyrsus.com> <E16bqC7-0004Mj-00@the-village.bc.nu> <20020215164610.A14418@thyrsus.com>
In-Reply-To: <20020215164610.A14418@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020215224321.GDLK22967.femail28.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 February 2002 04:46 pm, Eric S. Raymond wrote:

> Alan, don't talk to me about "proof of concept".  Tell me about a
> production-quality system, proven in use by people like Embedsys,
> Webmachines, and the Compache project.  Tell me you can duplicate what
> CML2 does successfully before you run around implying my design
> assumptions are full of crap.

Eric, step back a sec.  Deep breaths.

Nobody ever said CML1 had to be able to serve projects other than 
linux-kernel.  The fact CML2 can is nice, but irrelevant.  That argument goes 
nowhere.

The amount of time you've invested in your code isn't particularly 
interesting to anybody but you, except as an unreliable yardstick of how long 
it might take to duplicate things.  The "genius from mars" technique might be 
able to come up with an even better way in a week, you never know.  (Even a 
really hard problem space can be elegantly solved out of left field.  It's 
not likely, but you never know.)

The other side of the argument is that a proof of concept is not the same 
thing as actually solving the problem.  You have working code.  Several other 
people have unimplemented theoretical proposals, tests, and prototypes that 
don't actually do anything useful as of yet.  That's the main argument you 
should probably be making.

If people want to prove Eric wrong, then make CML1 work well.  If you believe 
it's not as hard a problem as he says it is, then by all means prove him 
wrong.  Arguing about how hard the problem really would be to solve, without 
actually solving it...  Why?

Rob
