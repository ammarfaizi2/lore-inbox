Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVAZAPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVAZAPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVAZANY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:13:24 -0500
Received: from mail.tmr.com ([216.238.38.203]:18194 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262258AbVAZAMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:12:19 -0500
Date: Tue, 25 Jan 2005 19:01:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: John Richard Moser <nigelenki@comcast.net>
cc: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <41F6A45D.1000804@comcast.net>
Message-ID: <Pine.LNX.3.96.1050125185641.18684A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, John Richard Moser wrote:


> Thus, by having fewer exploits available, fewer successful attacks
> should happen due to the laws of probability.  So the goal becomes to
> fix as many bugs as possible, but also to mitigate the ones we don't
> know about.  To truly mitigate any security flaw, we must make a
> non-circumventable protection.

To the extent that this means "if you see a bug, fix the bug, even if it's
unrelated" I agree completely.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

