Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVBOKjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVBOKjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVBOKjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:39:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:23277 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261670AbVBOKjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:39:16 -0500
Date: Tue, 15 Feb 2005 11:39:15 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20050215103915.GB2623@wotan.suse.de>
References: <20041028192104.GA3454@dualathlon.random> <20041105080716.GL8229@dualathlon.random> <20041105083102.GD16992@wotan.suse.de> <20041105084900.GN8229@dualathlon.random> <20050214231554.GQ13712@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214231554.GQ13712@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 12:15:54AM +0100, Andrea Arcangeli wrote:
> Hello,
> 
> the fix for this bug in 2.6.11-rc3 for this bug is wrong, I thought I

Can you describe what exactly is wrong? 

-Andi
