Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUDCWrq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 17:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUDCWrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 17:47:46 -0500
Received: from mail.shareable.org ([81.29.64.88]:919 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261998AbUDCWrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 17:47:45 -0500
Date: Sat, 3 Apr 2004 23:47:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Attila BODY <compi@freemail.hu>
Cc: linux-kernel@vger.kernel.org, Richard James <richard@techdrive.com.au>
Subject: Re: BUG: nforce IDE DMA with APIC enabled bug has re-emerged Kernel 2.6.4
Message-ID: <20040403224741.GC6122@mail.shareable.org>
References: <1081031766.1026.499.camel@smiley.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081031766.1026.499.camel@smiley.localnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attila BODY wrote:
> Can anyone enlighten me why isn't it merged to the mainstream kernel
> yet? I've found lots of people with the same problems while searching
> for the solution to mine, so it seems a common problem with some nforce2
> motherboards.

Perhaps because Ross Dickson's patches seem to fix the problem without
disabling those power saving & temperature reducing features.  But
there is no consensus yet, so you might want to try out his current
patches to see if they solve your problem, and give feedback.

-- Jamie
