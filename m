Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVBGS6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVBGS6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVBGS6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:58:47 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:637 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261238AbVBGS6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:58:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mpgnHoBFWSDUoOUHDpnV8IVzeBoYZj4uzi0aS2V4twr4bUzftVvPc1ItHQaZ+jmw6yozrDw4De7iShmooZZu4zepS1TfxuQzyeWsbgDUjS4t0P+62v7/+kfSLNbH52LyDolJqDX9Er3Uf1cEowWXJQp4/tJ4Z78KIo4a5lUZeq0=
Message-ID: <5a2cf1f6050207105874260920@mail.gmail.com>
Date: Mon, 7 Feb 2005 19:58:03 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: linux-os@analogic.com
Subject: Re: Please open sysfs symbols to proprietary modules
Cc: Chris Friesen <cfriesen@nortel.com>, Lee Revell <rlrevell@joe-job.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Pavel Roskin <proski@gnu.org>,
       Joseph Pingenot <trelane@digitasaru.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.61.0502071122410.22503@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
	 <20050203000917.GA12204@digitasaru.net>
	 <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>
	 <692795D1-758E-11D9-9D77-000393ACC76E@mac.com>
	 <1107674683.3532.26.camel@krustophenia.net>
	 <420791D7.3020408@nortel.com>
	 <Pine.LNX.4.61.0502071122410.22503@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005 11:55:31 -0500 (EST), linux-os <linux-os@analogic.com> wrote:
> On Mon, 7 Feb 2005, Chris Friesen wrote:
> 
> > Lee Revell wrote:
> >> On Wed, 2005-02-02 at 21:50 -0500, Kyle Moffett wrote:
> >>
> >>> It's not like somebody will have
> >>> some innate commercial advantage over you because they have your
> >>> driver source code.
> >>
> >>
> >> For a hardware vendor that's not a very compelling argument.  Especially
> >> compared to what their IP lawyers are telling them.
> >>
> >> Got anything to back it up?
> >
> > I have a friend who works for a company that does reverse-engineering of ICs.
> > Companies hire them to figure out how their competitor's chips work.  This is
> > the real threat to hardware manufacturers, not publishing the chip specs.
> >
> > Having driver code gives you the interface to the device.  That can be
> > reverse-engineered from watching bus traces or disassembling binary drivers
> > (which is how many linux drivers were originally written). Companies have
> > these kinds of resources.
> >
> > If you look at the big chip manufacturers (TI, Maxim, Analog Devices, etc.)
> > they publish specs on everything.  It would be nice if others did the same.
> >
> > Chris
> 
> I also have first-hand knowledge. Once there was a company called
> Data Precision. Just point your favorite search-engine to that
> name. They were a wholly owned subsidiary of Analogic. They
> no longer exist. Data Precision would take a year or more
> to develop a product. Six weeks after it was available on
> the market, it would have been cloned by Pacific-rim companies
> and dumped into the US at below US manufacturing cost.
> [..]

Shouldn't you be able to use legal action against companies that
provide such clones (at least in your country)? You could maybe even
sue the local resellers for participating to the fraud.

J
