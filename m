Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSGSGQ6>; Fri, 19 Jul 2002 02:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSGSGQ6>; Fri, 19 Jul 2002 02:16:58 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.98]:49097 "EHLO
	pimout5-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S315634AbSGSGQ4>; Fri, 19 Jul 2002 02:16:56 -0400
Message-Id: <200207190619.g6J6Jo2112432@pimout5-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Thunder from the hill <thunder@ngforever.de>
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Date: Thu, 18 Jul 2002 20:21:30 -0400
X-Mailer: KMail [version 1.3.1]
Cc: CaT <cat@zip.com.au>, Larry McVoy <lm@work.bitmover.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207182339080.3378-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207182339080.3378-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 July 2002 01:40 am, Thunder from the hill wrote:
> Hi,
>
> On Thu, 18 Jul 2002, Rob Landley wrote:
> > That's it, I'm going to go email Dennis Richie...
>
> If you want to be sure whether or not you can rely on index, you better go
> ask Maurice. I know another person who should have known that, but he's
> dead for quite long now. I never cared, unfortunately.
>
> 							Regards,
> 							Thunder

I emailed dmr but don't expect to hear from him before moring if he actually 
notices my email at all.

I did track down my copy of The design of the unix operating system and sure 
enough, on page 22, in section 2.2.1 (an overview of the file subsystem):

"The term inode is a contraction of the term <i>index node</i> and is 
commonly used in literature on the UNIX system."

That's probably good enough for me, actually.  Now my NEXT unanswered 
question is why the heck Darpa's "Information Awareness Office" has a picture 
of the Bavarian Illuminati in its logo, but I doubt that's something this 
list can help me with.  Me, I would have picked the gnomes of zurich.  Or the 
UFOs, for the second attack.  Or in the expansion pack, The Networks, since 
transferrable power is so useful anyway...

(P.S. I'm not quite kidding: http://www.darpa.mil/iao/ ).

Rob
