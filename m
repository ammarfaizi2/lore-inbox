Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUIMLB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUIMLB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 07:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUIMLB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 07:01:28 -0400
Received: from holomorphy.com ([207.189.100.168]:62090 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266488AbUIMLB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 07:01:27 -0400
Date: Mon, 13 Sep 2004 04:01:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040913110119.GA9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> consolidate-bit-waiting-code-patterns.patch
> eliminate-bh-waitqueue-hashtable.patch
> eliminate-bh-waitqueue-hashtable-fix.patch
> eliminate-inode-waitqueue-hashtable.patch
> move-wait-ops-contention-case-completely-out-of-line.patch
> reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
> document-wake_up_bits-requirement-for-preceding-memory-barriers.patch

For a general status update, suparna and I are working on the aio
integration with all this (well, thus far mostly suparna).


-- wli
