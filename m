Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVAOEUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVAOEUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVAOEUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:20:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:32676 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262091AbVAOEUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:20:05 -0500
Date: Fri, 14 Jan 2005 20:19:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Theodore Ts'o" <tytso@mit.edu>, Dave Jones <davej@redhat.com>,
       Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1105748623.9838.95.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501142018540.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> 
 <20050112174203.GA691@logos.cnet>  <1105627541.4624.24.camel@localhost.localdomain>
  <20050113194246.GC24970@beowulf.thanes.org>  <20050113200308.GC3555@redhat.com>
  <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org> 
 <1105644461.4644.102.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org>  <20050114183415.GA17481@thunk.org>
  <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org>  <20050114221343.GA18140@thunk.org>
  <Pine.LNX.4.58.0501141444360.2310@ppc970.osdl.org>
 <1105748623.9838.95.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Jan 2005, Alan Cox wrote:
> 
> vendor-sec has a lot of people on it who don't like long non-disclosure
> periods and get quite annoyed when they happen out of our control (eg
> CERT originated notifications). 

Hey, fair enough. I tend to see the problem cases, which may be why I
absolutely detest it. Statistical self-selection and all that.

		Linus
