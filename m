Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTBUPMN>; Fri, 21 Feb 2003 10:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTBUPMN>; Fri, 21 Feb 2003 10:12:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17928 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267484AbTBUPMM>; Fri, 21 Feb 2003 10:12:12 -0500
Date: Fri, 21 Feb 2003 10:17:52 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Shaya Potter <spotter@cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: hard lockup on 2.4.20 w/ nfs over frees/wan
In-Reply-To: <1045757772.31762.13.camel@zaphod>
Message-ID: <Pine.LNX.3.96.1030221101610.21493F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2003, Shaya Potter wrote:

> moved from the netfinity's onboard pcnet32 adapter to an IBM branded
> Intel epro/100 w/ the intel driver in 2.4.20 and it appears very
> stable.  Is it possible the pcnet/32 adapter is broken or the driver is
> buggy?

I've seen other reports of evil in that driver, I have the same Netfinity
hardware (5000's and 5100's) and I'm not even tempted to try a 2.5 kernel
on it as yet. I do have 2.5.59 and 2.5.61-ac1 kernels running in
non-critical systems, however.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

