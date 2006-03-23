Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWCWLsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWCWLsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWCWLsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:48:03 -0500
Received: from smtp-out-01.utu.fi ([130.232.202.171]:36252 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S1750716AbWCWLsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:48:01 -0500
Date: Thu, 23 Mar 2006 13:47:51 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: swap prefetching merge plans
In-reply-to: <44225BBF.2040604@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>,
       linux-kernel@vger.kernel.org
Message-id: <200603231347.51219.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200603230856.24091.volker.armin.hemmann@tu-clausthal.de>
 <44225BBF.2040604@yahoo.com.au>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 10:26, Nick Piggin wrote:
> Hemmann, Volker Armin wrote:
> > Hi,
> > 
> > I am just a user, but I would love to see this feature.
> > 
> > After compiling stuff, I have usually some kb in swap (300kb, 360 kb), and 
> > lots of free ram. But even this few kb make my KDE desktop extremly sluggish. 
> > It feels, like every byte is fetched individually and always the wrong stuff 
> > ends in swap.
> > 
> 
> I'm almost positive this wouldn't be the cause of your problems (even a
> slow disk could read all these blocks in, randomly, in under 2 seconds,
> assuming they're spread from one end of the platters to the other).

Maybe he meant 300 megabytes.

