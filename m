Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263464AbUJ2Uns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbUJ2Uns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbUJ2Ujz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:39:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:49371 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263497AbUJ2UcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:32:25 -0400
Date: Fri, 29 Oct 2004 22:32:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Ram?n Rey Vicente <ramon.rey@hispalinux.es>,
       Xavier Bestel <xavier.bestel@free.fr>,
       James Bruce <bruce@andrew.cmu.edu>,
       Andrea Arcangeli <andrea@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
In-Reply-To: <20041029173642.GA5318@work.bitmover.com>
Message-ID: <Pine.LNX.4.61.0410292132560.17266@scrub.home>
References: <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
 <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
 <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com>
 <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com>
 <41827B89.4070809@hispalinux.es> <20041029173642.GA5318@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Oct 2004, Larry McVoy wrote:

> And in lots of other places.  Which has been mentioned in this and other
> instances of this discussion for the last 5 years.  And the response is
> that BK already gives you documented ways to interoperate, extensively
> documented, in fact.  You can get data and/or metadata into and out of
> BK from the command line.  You could create your own network protocol,
> client, and server using the documented interfaces that BK has.  You
> could create your own CVS2BK tool, your own BK2CVS tool, etc., all
> using documented interfaces.

Wow, now I'm really interested, how this fits together with this mail: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=109884946914484

What I'm asking for there is the _minimum_ amount of information to do 
exactly the above. Is there somewhere a provision like "unless you give 
this data to evil bk haters"?

To make this easier to understand for everyone, here is a simple example: 
a very simple network protocol would be to extend the current commit mails 
with the identifiers one can already find in bkcvs, so they can be put 
into the correct order.

The million Euro question is now: How can he decline me this information 
on the one hand (note: I didn't ask that he gives me this himself) and on 
the other hand how will he prevent me from getting to this information, if 
someone does exactly the above?
For the answer to this question stay tuned and don't switch the channel...

bye, Roman
