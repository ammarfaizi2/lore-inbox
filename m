Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRIDQoR>; Tue, 4 Sep 2001 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271998AbRIDQoH>; Tue, 4 Sep 2001 12:44:07 -0400
Received: from www.transvirtual.com ([206.14.214.140]:47882 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S271997AbRIDQn5>; Tue, 4 Sep 2001 12:43:57 -0400
Date: Tue, 4 Sep 2001 09:44:10 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Simon Hay <simon@haywired.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
In-Reply-To: <3B93CF91.A6D59DA8@haywired.org>
Message-ID: <Pine.LNX.4.10.10109040941490.22429-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Apologies in advance if this is a question that's already been answered
> somewhere...  I'm looking for a way to install multiple (or rather, two)
> PCI/AGP cards in a machine and connect a monitor to each one, and use
> them both *in console mode* - preferably with some nice way to say
> 'assign virtual console 2 to the first screen, and 5 to the second' -
> that way you could have one tailing log files, showing 'top', whatever. 
> A quick search of the web/newsgroups turned up various patches that
> looked ideal, but a closer inspection revealed that they either relied
> on you having a Hercules mono card, or only applied against kernel
> <0.99, or both...  I was just wondering if anyone's thought
> about/written a similar patch for more recent hardware/versions?  I was
> using a console Linux machine running BB (ASCII art demo -
> http://aa-project.sourceforge.net/) just to attract attention to our
> stand today and was thinking it would be really neat to have one machine
> driving several screens...

Hi!

  Tkae a look at the linux console project.

http://www.sf.net/projects/linuxconsole. 

  I pretty much have rewritten the console system. I have been running a
multidesktop system for some time now. It needs some more work but the
core of it is their.  

