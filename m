Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUBLVmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUBLVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:42:04 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:8924 "EHLO fed1mtao04.cox.net")
	by vger.kernel.org with ESMTP id S266615AbUBLVmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:42:01 -0500
Date: Thu, 12 Feb 2004 14:44:07 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Derek Foreman <manmower@signalmarketing.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Message-ID: <20040212214407.GA865@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Derek Foreman <manmower@signalmarketing.com>,
	linux-kernel@vger.kernel.org
References: <200402120122.06362.ross@datscreative.com.au> <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 12:17:12PM -0600, Derek Foreman wrote:
> Some nforce2 systems work just fine.  Is there a way to distinguish
> between systems that need it and those that don't?
> 

Some nforce2 systems are fixed in certain bioses.  The problem is we don't know where/what it is in the bios.  C1 disconnect is a clue.

> (if anyone's running a betting pool, my money's on nforce2+cpu with half
> frequency multiplier ;)

I don't know what your talking about.  My Shuttle AN35N nforce2 board can run vanilla kernels with the 12-5-2003 dated bios version and not lock up.  The frequencies I run are all the default/standard ones.

Jesse
