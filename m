Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265786AbUFDNKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265786AbUFDNKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUFDNKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:10:23 -0400
Received: from main.gmane.org ([80.91.224.249]:25567 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265787AbUFDNKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:10:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andy Hawkins <andy@gently.org.uk>
Subject: Re: DriveReady SeekComplete Error
Date: Fri, 4 Jun 2004 13:02:18 +0000 (UTC)
Organization: Gently
Message-ID: <slrncc0smq.i1n.andy@gently.org.uk>
References: <20040604075448.GK18885@web1.rockingstone.nl> <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk> <20040604095409.GL18885@web1.rockingstone.nl> <20040604095900.GO1946@suse.de> <20040604100258.GM18885@web1.rockingstone.nl> <20040604100813.GP1946@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpc3-swin2-3-0-cust120.brhm.cable.ntl.com
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In article <20040604100813.GP1946@suse.de>,
           Jens Axboe<axboe@suse.de> wrote:
> The that's a known error, you should not worry about it. It's fixed in
> later kernels.

I'm seeing this error too, and also frequent crashes (total lock ups) of the
machine (every day or two at the moment). Could the two be related?

I haven't got round to doing any diagnostics yet, but there's nothing
obvious in the logs. I was going to dismantle the machine and check
connections etc. first.

Andy

