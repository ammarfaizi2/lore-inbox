Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277891AbRJIUvB>; Tue, 9 Oct 2001 16:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277962AbRJIUuv>; Tue, 9 Oct 2001 16:50:51 -0400
Received: from adsl-216-102-163-254.dsl.snfc21.pacbell.net ([216.102.163.254]:32659
	"EHLO windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S277891AbRJIUuj>; Tue, 9 Oct 2001 16:50:39 -0400
Date: Tue, 9 Oct 2001 13:48:27 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: "Trever L. Adams" <trever_adams@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
In-Reply-To: <1002652844.3356.1.camel@aurora>
Message-ID: <Pine.LNX.4.33.0110091348010.15092-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Oct 2001, Trever L. Adams wrote:

> On Tue, 2001-10-09 at 14:31, Jeffrey W. Baker wrote:
> > I mean connections originating from userland processes running on the
> > machine with iptables configured.  This machine does not act as a NAT or
> > router for any other machine.
> >
> > We make about 200000 outbound connections to web sites in a day.  Of these
> > connections, a few thousand get fucked up by iptables (iptables suddenly
> > decides to drop packets on this connection).
> >
> > -jwb
>
> Mine does NAT.  So it appears this is not NAT related (though it may be
> further aggravated by NAT).  My connection rate is FAR lower than
> yours.  Our total connections may be 100,000 on a high rate day (just a
> guess... I really do not know).

My machine has three IP addrs bound to one physical interface and uses
policy routing.  Do you use any of those?

-jwb

