Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUEaIKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUEaIKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 04:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264572AbUEaIKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 04:10:46 -0400
Received: from main.gmane.org ([80.91.224.249]:8154 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264562AbUEaIKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 04:10:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Calvin Spealman <calvin@ironfroggy.com>
Subject: Re: How to use floating point in a module?
Date: Mon, 31 May 2004 03:57:18 +0000
Message-ID: <2381159.W1mTlBeItA@ironfroggy.com>
References: <200405310152.i4V1qNk03732@mailout.despammed.com> <yw1xbrk5baq3.fsf@kth.se> <Pine.LNX.4.58.0405302121440.1730@ppc970.osdl.org>
Reply-To: calvin@ironfroggy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-069-132-046-251.carolina.rr.com
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> kernel_fpu_begin();
> ...
> kernel_fpu_end();

Don't you love having ideas and just finding they're already well know, in
use, or obsolete?

