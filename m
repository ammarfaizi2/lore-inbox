Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264193AbRF1UGz>; Thu, 28 Jun 2001 16:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRF1UGp>; Thu, 28 Jun 2001 16:06:45 -0400
Received: from mail.zmailer.org ([194.252.70.162]:17676 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S264209AbRF1UGi>;
	Thu, 28 Jun 2001 16:06:38 -0400
Date: Thu, 28 Jun 2001 23:06:10 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Michael J Clark <clarkmic@pobox.upenn.edu>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: TCP/IP stack
Message-ID: <20010628230610.K8897@mea-ext.zmailer.org>
In-Reply-To: <200106281433.f5SEXk800876@pobox.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200106281433.f5SEXk800876@pobox.upenn.edu>; from clarkmic@pobox.upenn.edu on Thu, Jun 28, 2001 at 10:33:46AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Richard, should there be (is there?)  linux-networking-faq, or can this
  be put into the  linux-kernel  faq ?

On Thu, Jun 28, 2001 at 10:33:46AM -0400, Michael J Clark wrote:
> hey guys,
> 
> I have been reading through TCP/IP Illustrated Vol 2 and the linux 
> source.

   That book describes  BSD  implementation.

   Linux code has been written completely independently, and using
   fundamentally different base structure -- instead of PCBs containing
   chains of segments, Linux has  SKBs  with entire segment contiguous
   in it.

   Function, and structure names are different, naturally.

> Mike

/Matti Aarnio
