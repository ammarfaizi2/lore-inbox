Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTIZC0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 22:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbTIZC0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 22:26:47 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:21150 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261351AbTIZC0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 22:26:46 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
	<m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 26 Sep 2003 11:25:07 +0900
In-Reply-To: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
Message-ID: <buooex8477g.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
> ARCH is barely distributed and architecturally it makes distributed
> merging hard.

Are you are kidding?  Arch is _insanely_ good at handling both
distributed repositories and merging -- those are if anything its
greatest strengths.  Everyday development of tla (the latest/greatest
arch implementation) involves many people with their own repositories,
merging back and forth.

Really, if you have explicit complaints/observations about arch's
handling of these things, please share them, because on the surface
that statement just seems kind of bizarre.

-Miles
-- 
`The suburb is an obsolete and contradictory form of human settlement'
