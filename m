Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVKJAQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVKJAQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKJAQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:16:13 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:18310 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751098AbVKJAQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:16:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: merge status
Date: Thu, 10 Nov 2005 11:16:46 +1100
User-Agent: KMail/1.8.3
Cc: James Bottomley <James.Bottomley@steeleye.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       axboe@suse.de, shaggy@austin.ibm.com, sfrench@us.ibm.com
References: <20051109133558.513facef.akpm@osdl.org> <1131575124.8541.9.camel@mulgrave> <20051109150141.0bcbf9e3.akpm@osdl.org>
In-Reply-To: <20051109150141.0bcbf9e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101116.47034.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005 10:01 am, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> > it's my contributors who drop me in it
> > by leaving their patch sets until you declare a kernel, dumping the
> > integration testing on me in whatever time window is left.
>
> Yes, I think I'm noticing an uptick in patches as soon as a kernel is
> released.
>
> It's a bit irritating, and is unexpected (here, at least).  I guess people
> like to hold onto their work for as long as possible so when they release
> it, it's in the best possible shape.

I suspect part of that is the concern about whether the code will merge with 
whatever -mm looks like next. Of course you already do ludicrous amounts of 
merging, but sometimes you'll just throw it back and say "too many rejects".

Cheers,
Con
