Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTHYQXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbTHYQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:23:20 -0400
Received: from zero.aec.at ([193.170.194.10]:62213 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261944AbTHYQXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:23:19 -0400
Date: Mon, 25 Aug 2003 18:23:03 +0200
From: Andi Kleen <ak@muc.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Martin Pool <mbp@sourcefrog.net>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-ID: <20030825162303.GA7288@averell>
References: <aJIn.3mj.15@gated-at.bofh.it> <m3smp3y38y.fsf@averell.firstfloor.org> <pan.2003.08.13.04.40.27.59654@sourcefrog.net> <20030813110453.GA26019@colin2.muc.de> <87y8xiexue.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8xiexue.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 08:16:41AM -0400, Greg Stark wrote:
> There was a proposal a long ways back to allow X to download instructions to
> the kernel on how to restore the video mode. The proposal was to code the
> instructions as a forth program that frobbed registers appropriately. The
> kernel would have a small forth interpretor to run it. Then switching
> resolutions could happen safely in the kernel.

Did the proposal come with working code?

-Andi
