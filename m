Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266959AbUBMMhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266964AbUBMMhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:37:43 -0500
Received: from gaia.cela.pl ([213.134.162.11]:57614 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S266959AbUBMMhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:37:41 -0500
Date: Fri, 13 Feb 2004 13:37:34 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Junio C Hamano <junkio@cox.net>, Michael Frank <mhf@linuxmail.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
In-Reply-To: <200402130918.45587.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0402131322280.12513-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You haven't made your point with this post.

Dots are meant to end sentences not lines.
If a line is not a sentence there's no point in adding a period. Period.
However if a message is basically a sentence then like any sentence it 
should end with a period.  There's no philosophy to this.

The majority of kernel messages aren't sentences and thus are dot-free. 
Some however are, and these usually look better with the ending periods.  
However, whether these ending periods are necessary depends mainly on the 
length of the sentence, on whether they end with numerals or acronyms and 
a matter of personal taste.

On Fri, 13 Feb 2004, vda wrote:

> On Friday 13 February 2004 08:41, Junio C Hamano wrote:
> 
> > MF> +Periods terminating kernel messages are deprecated
> > MF> +Usage of the apostrophe <'> in kernel messages is deprecated
> >
> > I do not think encouraging bad spelling like above has reached
> > community consensus.  Personally I do not like those sloppy
> > grammar ("donts" and missing period at the end of the sentence).
> 
> 126MB LOWMEM available
> Detected 1196.031 MHz processor
> Intel machine check architecture supported
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware

In your post only the above could be considered sentences and even then
most are really too short, or end with numerals or acronyms which make
dots look stupid.  Personally I'd think the "Intel machine check
architecture supported." message looks better with a period and I'd leave
all the rest alone.  Nevertheless, all 5 of the above could possibly end 
with periods, the rest never.

De gusto non est disputandum - cheers,
MaZe.


