Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbSJFQPX>; Sun, 6 Oct 2002 12:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJFQOv>; Sun, 6 Oct 2002 12:14:51 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:25585 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261658AbSJFQOk>; Sun, 6 Oct 2002 12:14:40 -0400
Subject: Re:  BK MetaData License Problem?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 17:29:07 +0100
Message-Id: <1033921747.21257.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 14:13, Ingo Molnar wrote:
> yes, but what i say is that BK *creates* a problem, (just like CVS would
> create similar problems) and the license clearly shows that BM is aware of
> and tries to handle part of this legal problem. (And given that the BK
> metadata is richer than eg. CVS, i suspect it will be a magnified problem
> later on.)

The onyl real problem BK creates here IMHO is its not possible to use BK
to maintain the true master tree of a piece of software, because like
everyone else Linux people get security reports/fixes which are set to
go out on specific dates by people like CERT. The BK rules prevent
anyone from checking a change into their BK tree until the embargo date,
which can be a pain in the butt.

Fortunately its not a problem to me because I don't use it 8)


