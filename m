Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUBZNkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUBZNkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:40:07 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:6532 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S262792AbUBZNkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:40:00 -0500
Date: Thu, 26 Feb 2004 05:39:59 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
Message-ID: <20040226133959.GA19254@dingdong.cryptoapps.com>
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 09:32:08PM -0800, Nakajima, Jun wrote:

> Yes, "implementation specific" is one of the differences between
> IA-32e and AMD64, i.e. that behavior is architecturally defined on
> AMD64, but on IA-32e (as I posted):

>   Near branch with 66H prefix:
>     As documented in PRM the behavior is implementation specific and
>     should avoid using 66H prefix on near branches.


Not that it really matters that much --- but I'm curious to know why
Intel made this decision?

It seems really dumb to make such differences when Intel is already
sorely lagging behind their competitor here, I would think given the
circumstances Intel would try to be as compatible as possible on all
fronts.

I'd almost be nervous about getting an IA-32e CPU right now given that
the AMD64 chips work just fine, have had lots of testing and there is
plenty of code out there which is *known* to work reliably.



