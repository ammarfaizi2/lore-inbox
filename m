Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbUDGNRj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUDGNRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:17:39 -0400
Received: from ns.suse.de ([195.135.220.2]:49561 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263354AbUDGNRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:17:37 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040406190034.E22989@build.pdx.osdl.net>
References: <1081274618.30828.30.camel@watt.suse.com>
	 <20040406190034.E22989@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1081343972.30828.528.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Apr 2004 09:19:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 22:00, Chris Wright wrote:

> Would you consider adding the bd_claim on external journal bdev I posted
> a while back?  Hans didn't seem to flat out reject, and you agreed one
> journal per bdev was sufficient.
> 
> Patch below, updated to 2.6.5-linus, and applies with fuzz atop your
> series.linus.  I also have the reiserfsprogs update if you're interested.

I don't remember anyone having a problem with it, you'll need some
language at the top of the patch giving Hans the copyright on it.

-chris


