Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSJVSFG>; Tue, 22 Oct 2002 14:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbSJVSDx>; Tue, 22 Oct 2002 14:03:53 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:50874 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264800AbSJVSDe>; Tue, 22 Oct 2002 14:03:34 -0400
Subject: Re: Son of crunch time: the list v1.2.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Wourms <nwourms@netscape.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB58F56.9030208@netscape.net>
References: <20021021135137.2801edd2.rusty@rustcorp.com.au>
	<200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com>
	<200210211642.10435.landley@trommello.org> <3DB4BD8F.1010707@pobox.com>
	<ap420c$m3v$1@main.gmane.org> <20021022184041.A2142@infradead.org> 
	<3DB58F56.9030208@netscape.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 19:25:41 +0100
Message-Id: <1035311141.329.128.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 18:48, Nicholas Wourms wrote:
> Christoph Hellwig wrote:
> > On Tue, Oct 22, 2002 at 01:32:49PM -0400, Nicholas Wourms wrote:
> > 
> >>As was stated by Dave Jones[1], this is something that will probably should 
> >>go in after the freeze.  I'm afraid that having seperate patches is just 
> >>unacceptable.
> > 
> > 
> > If you want your volume manager of choice beein included in 2.6 help to
> > get it in shape quickly.  It's rather simple..
> > 
> 
> Like arguing with a brick wall...

I will agree. I will observe two details
	1. The wall normally wins
	2. Christoph is right

In the mean time it would really help if people took the EVMS/LVM2
debate down to the technical aspects not the marketing ones (at least on
this list). That means fixing the bugs, cleaning up the code, auditing
it etc.

The folks who want to have long rambling discussions rather than fix the
code or test it are encouraged to find a private brick wall, bartender
(or different list) to talk at

