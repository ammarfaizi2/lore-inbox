Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbTFLBpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbTFLBpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:45:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60400 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264660AbTFLBpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:45:42 -0400
Subject: Re: [patch] as-iosched divide by zero fix
From: Robert Love <rml@tech9.net>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@digeo.com>, bos@serpentine.com,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
In-Reply-To: <1055382871.28430.9.camel@spc>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
	 <1055380257.662.8.camel@localhost>  <1055382871.28430.9.camel@spc>
Content-Type: text/plain
Message-Id: <1055383260.662.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jun 2003 19:01:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 18:54, Steven Cole wrote:

> With regards to the last, here is an anti-AOL! for the oops.  I ran
> 2.5.70-mm8 for several hours today, doing kernel compiles and running
> dbench 64 on ext3, xfs, and jfs.  No oops.  
> 
> All while running X (although that now seems moot).  Base distro is RH9
> if that could matter.  System is UP (PIII), PREEMPT, IDE, i810 chipset.

Right. Most people are not seeing this.

I have a system very similar to yours, interestingly. It is just random
timings I guess.

	Robert Love

