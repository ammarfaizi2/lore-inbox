Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTBTQeV>; Thu, 20 Feb 2003 11:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTBTQeU>; Thu, 20 Feb 2003 11:34:20 -0500
Received: from havoc.daloft.com ([64.213.145.173]:6805 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265815AbTBTQeU>;
	Thu, 20 Feb 2003 11:34:20 -0500
Date: Thu, 20 Feb 2003 11:44:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard lockup on 2.4.20 w/ nfs over frees/wan
Message-ID: <20030220164420.GA9800@gtf.org>
References: <1045634189.4761.44.camel@zaphod> <1045686971.8084.2.camel@zaphod> <1045757772.31762.13.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045757772.31762.13.camel@zaphod>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:16:13AM -0500, Shaya Potter wrote:
> moved from the netfinity's onboard pcnet32 adapter to an IBM branded
> Intel epro/100 w/ the intel driver in 2.4.20 and it appears very
> stable.  Is it possible the pcnet/32 adapter is broken or the driver is
> buggy?

I have gotten reports the 2.4.20 pcnet32 is buggy.

Can you test 2.4.20 with 2.4.19 version of pcnet32.c?

