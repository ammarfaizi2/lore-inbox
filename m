Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbUCJT5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbUCJT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:57:32 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:2698 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S262812AbUCJT45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:56:57 -0500
Date: Wed, 10 Mar 2004 19:56:08 +0000
From: backblue <backblue@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: a7n8x-x & i2c
Message-Id: <20040310195608.54635d8b.backblue@netcabo.pt>
In-Reply-To: <1078945499.8828.10.camel@athlonxp.bradney.info>
References: <20040310185047.454779fc.backblue@netcabo.pt>
	<1078945499.8828.10.camel@athlonxp.bradney.info>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2004 19:56:33.0279 (UTC) FILETIME=[C993C0F0:01C406D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It only crashes with i2c, the kernel it's working nicelly, at the moment, but without i2c, if i compile it with i2c build in, it crashes.

On Wed, 10 Mar 2004 20:05:00 +0100
Craig Bradney <cbradney@zip.com.au> wrote:

> Hi,
> 
> > I have compiled 2.6.3, with i2c suporte for my chipset "nforce2" to the board asus a7n8x-x, but, it crashes my box all the time, dont know why!
> > But it only crashes after login and a couple of minutes working...
> > any one know womething about this?
> 
> Is the crash only with i2c or are you just trying linux on this board?
> 
> Craig
> 
