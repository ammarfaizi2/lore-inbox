Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUDPO7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUDPO7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:59:47 -0400
Received: from mail.cyclades.com ([64.186.161.6]:14302 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263252AbUDPO67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:58:59 -0400
Date: Fri, 16 Apr 2004 11:23:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
Message-ID: <20040416142311.GD2253@logos.cnet>
References: <Pine.LNX.4.10.10404160227080.22035-100000@master.linux-ide.org> <Pine.LNX.4.10.10404160259480.22035-100000@master.linux-ide.org> <20040416135102.GB1485@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416135102.GB1485@logos.cnet>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:51:02AM -0300, Marcelo Tosatti wrote:
> 
> Marcelo,
> 
> You are suggesting that 2.6 is not stable ?  How could that be ?

It is stable, but some people still use 2.4 for production machines, and 
will still do for sometime.

> Should it not be backported to 2.2 and why not 2.0 ?

The amount of people using 2.2/2.0 and SATA is probably small.

But sure, why dont you start the backport ?

> What about the rest of the feature sets ?

This is not like "the rest of the feature sets", this is 
basic functionality needed to support new systems in the market.

And again, unfortunately not everyone is running v2.6 on their production
environment, yet.

> Necessary? But their is the new and improved called 2.6.
> It is time for the old and lousy to quietly wimper off and die.

Right, the old and lousy should wimper off and die. But this is 
a special case (a lot of people are applying SATA by hand, look at lkml).

