Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUCKUEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUCKUEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:04:46 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:27253 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S261689AbUCKUEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:04:41 -0500
Date: Thu, 11 Mar 2004 20:04:00 +0000
From: backblue <backblue@netcabo.pt>
To: Craig Bradney <cbradney@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: a7n8x-x & i2c
Message-Id: <20040311200400.37337424.backblue@netcabo.pt>
In-Reply-To: <1078953283.8828.24.camel@athlonxp.bradney.info>
References: <20040310185047.454779fc.backblue@netcabo.pt>
	<1078945499.8828.10.camel@athlonxp.bradney.info>
	<20040310195608.54635d8b.backblue@netcabo.pt>
	<1078953283.8828.24.camel@athlonxp.bradney.info>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2004 20:04:22.0240 (UTC) FILETIME=[0B834600:01C407A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If i run sensors-detect, it doesn't detect any chips, does a7n8x-x should work?

On Wed, 10 Mar 2004 22:14:43 +0100
Craig Bradney <cbradney@zip.com.au> wrote:

> Ok, thought you might have had the nForce2 bug issue as well. Perhaps
> you haave already patched for that.
> 
> Craig
> 
> On Wed, 2004-03-10 at 20:56, backblue wrote:
> > It only crashes with i2c, the kernel it's working nicelly, at the moment, but without i2c, if i compile it with i2c build in, it crashes.
> > 
> > On Wed, 10 Mar 2004 20:05:00 +0100
> > Craig Bradney <cbradney@zip.com.au> wrote:
> > 
> > > Hi,
> > > 
> > > > I have compiled 2.6.3, with i2c suporte for my chipset "nforce2" to the board asus a7n8x-x, but, it crashes my box all the time, dont know why!
> > > > But it only crashes after login and a couple of minutes working...
> > > > any one know womething about this?
> > > 
> > > Is the crash only with i2c or are you just trying linux on this board?
> > > 
> > > Craig
> > > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
