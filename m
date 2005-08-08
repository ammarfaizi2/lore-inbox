Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753226AbVHHBrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbVHHBrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbVHHBrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:47:18 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:17043 "EHLO
	smtp-05.primus.ca") by vger.kernel.org with ESMTP id S1753226AbVHHBrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:47:18 -0400
From: Gabriel Devenyi <ace@staticwave.ca>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Date: Sun, 7 Aug 2005 21:45:21 -0400
User-Agent: KMail/1.8.2
Cc: Con Kolivas <kernel@kolivas.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, tony@atomide.com,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       tuukka.tikkanen@elektrobit.com, george@mvista.com
References: <200508031559.24704.kernel@kolivas.org> <C845464B-FE91-4845-BE7A-3995B663396D@mac.com> <200508081130.23636.kernel@kolivas.org>
In-Reply-To: <200508081130.23636.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508072145.22203.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Along the same lines, is there an x86_64 patch around?

On August 07, 2005 21:30, Con Kolivas wrote:
> On Mon, 8 Aug 2005 11:20 am, Kyle Moffett wrote:
> > On Aug 7, 2005, at 19:51:25, Con Kolivas wrote:
> > > On Mon, 8 Aug 2005 02:58, Srivatsa Vaddagiri wrote:
> > >> Con,
> > >>     I am afraid until SMP correctness is resolved, then this is not
> > >> in a position to go in (unless you want to enable it only for UP,
> > >> which
> > >> I think should not be our target). I am working on making this work
> > >> correctly on SMP systems. Hopefully I will post a patch soon.
> > >
> > > Great! I wasn't sure what time frame you meant when you last
> > > posted. I won't
> > > do anything more, leaving this patch as it is, and pass the baton
> > > to you.
> >
> > I'm curious what has happened to the PPC side of the patch.  IIRC,
> > someone
> > was working on such a port, but it seems to have been lost along the way
> > at some point.  Is there any additional information on that patch?
>
> Tony said he had it lying around somewhere and needed to find time to dust
> it off and get it up to speed.
>
> Cheers,
> Con
> _______________________________________________
> ck@vds.kolivas.org
> ck mailing list. Please reply-to-all when posting.
> If replying to an email please reply below the original message.
> http://bhhdoa.org.au/mailman/listinfo/ck

-- 
Gabriel Devenyi
ace@staticwave.ca
