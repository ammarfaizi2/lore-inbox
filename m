Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUHYBhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUHYBhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUHYBhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:37:46 -0400
Received: from main.gmane.org ([80.91.224.249]:28559 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269090AbUHYBhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:37:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Date: Tue, 24 Aug 2004 18:37:41 -0700
Message-ID: <412BED65.5060709@triplehelix.org>
References: <412B5B35.7020701@apartia.fr>	<20040824092533.65cb32da.rddunlap@osdl.org> <20040824113407.287f0408.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: lcaron@apartia.fr, linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-194-252.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
In-Reply-To: <20040824113407.287f0408.davem@redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Oh on the contrary, I've never seen a call to request_firmware()
> in any copy of the tg3 driver and that's strange being that I'm
> the maintainer. :-)
> 
> People, if you're going to use patched up kernels, report your
> problems to the people you got the kernel from.  Thanks.

As a matter of fact this is most certainly kernel-source-2.4.27 from 
Debian. This problem was recently fixed (as discussed in the mini-thread 
about how CML1 blows chunks.)

For what it's worth to Google, kernel-tree-2.4.27-4 has just hit 
unstable (will reach mirrors by tomorrow) and should have fixed this 
problem.

Sorry for the noise caused to LKML.

-- 
Joshua Kwan

