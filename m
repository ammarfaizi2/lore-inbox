Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbUDFOUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUDFOUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:20:11 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:19719 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263888AbUDFOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:20:05 -0400
Date: Tue, 6 Apr 2004 22:22:14 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] 2.6 patches broken with 2.6.4
In-Reply-To: <20040315105227.0d677dd8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404062207540.5560@raven.themaw.net>
References: <Pine.LNX.4.44.0312022129550.2970-100000@raven.themaw.net>
 <4050BE51.6010908@yahoo.com> <Pine.LNX.4.58.0403120910270.7863@wombat.indigo.net.au>
 <20040311213232.51d08dba.akpm@osdl.org> <Pine.LNX.4.58.0403140810170.4585@raven.themaw.net>
 <20040313182144.342d770e.akpm@osdl.org> <Pine.LNX.4.58.0403151825370.4605@raven.themaw.net>
 <20040315105227.0d677dd8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

My updated autofs4 patches for 2.6 are located at:

http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/2.6.4

They also apply OK to the recent 2.6.5 release.

I asked Peter Anvin to review them but it appears he doesn't have time 
atm.

On Mon, 15 Mar 2004, Andrew Morton wrote:

> > Please don't spend much time checking the patches I described in my last 
> > mail. I've just started reviewing them and can see there is quite a bit 
> > more I can do to break them up in the way you have recommened. It will 
> > take a couple of days.
> > 
> 
> I started to look at them a bit.  They seem reasonable from a first pass. 
> We'll need to go through them carefully.

Please do. I'm keen to get feedback on errors and comments for 
improvement.

> 
> Time spent commenting the code and explaining the rationale behind the
> changes (in a form suitable for the final changelog) is always well spent.
> 

All that I've done is to add a description and purpose to the begining of 
each patch. I thought the code was fairly readable and mostly obvious. 
Please let me know if you find this is not the case and I will add 
comments where recommended. So don't waste time trying to work stuff out 
if its not clear, just get in touch.

Ian

