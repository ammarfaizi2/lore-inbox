Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTJWPVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTJWPVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:21:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13185 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263599AbTJWPVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:21:05 -0400
Date: Thu, 23 Oct 2003 16:22:56 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310231522.h9NFMuwe006616@81-2-122-30.bradfords.org.uk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0310231106210.21154@montezuma.fsmlabs.com>
References: <200310230930.h9N9U0B4006046@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.53.0310231024160.21154@montezuma.fsmlabs.com>
 <200310231501.h9NF164o006515@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.53.0310231106210.21154@montezuma.fsmlabs.com>
Subject: Re: In-kernel Gopher server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Zwane Mwaikambo <zwane@arm.linux.org.uk>:
> On Thu, 23 Oct 2003, John Bradford wrote:
> 
> > Maybe the wristwatch example was a bit extreme, but what about a
> > system with very low bandwidth for connectivity?  What if you were
> > trying to get configuration data back from a spacecraft millions of
> > miles away?  At 300 BPS or less, and hours of latency, Gopher starts
> > to look a bit more realistic than getting a shell prompt via ssh :-).
> 
> Ok so i've missed the point as to why we need it in the kernel.

There probably isn't one.  It would be perfectly do-able in userspace.

John.
