Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVFUQM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVFUQM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVFUQM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:12:28 -0400
Received: from waste.org ([216.27.176.166]:40107 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262135AbVFUQMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:12:20 -0400
Date: Tue, 21 Jun 2005 09:12:15 -0700
From: Matt Mackall <mpm@selenic.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Mercurial 0.5b vs git
Message-ID: <20050621161215.GN27572@waste.org>
References: <20050531213103.GR7685@waste.org> <200506211803.58339.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506211803.58339.michael@ellerman.id.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 06:03:51PM +1000, Michael Ellerman wrote:
> Hey Matt,
> 
> It doesn't look like your mercurial repo of the kernel is updating, is that 
> right? The last tag I see is v2_6_12-rc2.

a) It doesn't currently pull the git tags.
b) It stopped working this weekend when someone committed one of those
octopus merges, which I had deferred dealing with because they're so
stupid.

Both should be fixed shortly.

Btw, it's also moved from userweb.kernel.org to www.kernel.org/hg/.

-- 
Mathematics is the supreme nostalgia of our time.
