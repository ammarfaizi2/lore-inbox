Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275200AbTHRWDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275126AbTHRWDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:03:30 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52494 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275124AbTHRWD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:03:27 -0400
Date: Mon, 18 Aug 2003 17:54:37 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <20030818053007.7852ca77.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1030818173940.2101F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, David S. Miller wrote:

> On Mon, 18 Aug 2003 14:34:01 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > what is the _positive_ outcome of this
> > implementation compared to others?
> 
> If you're not willing to think I can't help you resolve
> the questions you have.

Trying to think of something you have never seen is like trying to think
of a new color. I can not think of a case where the current default
behaviour is better (you can define that as your will, in terms of either
functionality or convenience).

> 
> If you don't understand source address selection, than it's
> not possible for me to have an intellegent conversation about
> this topic.
> 
> So you need to make this crucial first step.
> 

Good buzz words, your mailer dropped the URL of the document with the
examples... Complaining that people don't understand without providing a
pointer to some help for that lack is not helping them (or reducing the
call for changes). If you want people to stop asking for patches help them
do what they need to do.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

