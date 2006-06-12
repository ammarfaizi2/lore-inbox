Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752106AbWFLQE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbWFLQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbWFLQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:04:57 -0400
Received: from xenotime.net ([66.160.160.81]:52159 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752106AbWFLQE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:04:57 -0400
Date: Mon, 12 Jun 2006 09:07:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Barry Scott <barry.scott@onelan.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6 Section mismatch warnings
Message-Id: <20060612090742.011bf483.rdunlap@xenotime.net>
In-Reply-To: <448D6B53.3070803@onelan.co.uk>
References: <4488057A.9090301@onelan.co.uk>
	<20060608195902.26902ef0.rdunlap@xenotime.net>
	<448D6B53.3070803@onelan.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 14:25:39 +0100 Barry Scott wrote:

> Randy.Dunlap wrote:
> > On Thu, 08 Jun 2006 12:09:46 +0100 Barry Scott wrote:
> >
> >   
> >> When I built 2.6.17-rc6 I see a lot of warnings after the MODPOST message
> >> about Section mismatch. What did I do wrong in building the kernel and 
> >> modules?
> >>     
> > ...
> >   
> >> Here are some of the warnings:
> >>     
> >
> > It would be helpful if someone could look at/work on the
> > section mismatches in the isdn and sound drivers...
> >
> > I have 6 new patches to post, then I'll be
> > sweeping the net drivers soon.
> >   
> The alsa folks have fixed their problem and you should see a patch from them
> shortly.
> 
> Any news on the net driver problems?

Sorry, I posted patches for a bunch of net drivers and forgot to
copy you on them.  On Sat., 2006-June-10, on the netdev mailing
list, patches for smc, hp, & 3c5zz:

http://marc.theaimsgroup.com/?l=linux-netdev&m=114997161622800&w=2
http://marc.theaimsgroup.com/?l=linux-netdev&m=114997161630191&w=2
http://marc.theaimsgroup.com/?l=linux-netdev&m=114997161722035&w=2


---
~Randy
