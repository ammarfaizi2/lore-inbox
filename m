Return-Path: <linux-kernel-owner+w=401wt.eu-S964861AbXADOBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbXADOBW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 09:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbXADOBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 09:01:21 -0500
Received: from jeffindy.licquia.org ([216.54.159.123]:35541 "EHLO
	jeffindy.licquia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964861AbXADOBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 09:01:21 -0500
X-Greylist: delayed 1522 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 09:01:20 EST
Subject: Re: Alternative msync() fix for 2.6.18?
From: Jeff Licquia <jeff@licquia.org>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Hugh Dickins <hugh@veritas.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       394392@bugs.debian.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <1167834727.3798.6.camel@xenpc.internal.licquia.org>
References: <20061226123106.GA32708@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612261305510.18364@blonde.wat.veritas.com>
	 <20061226132547.GC6256@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612261411580.20159@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0612270104020.11930@blonde.wat.veritas.com>
	 <20061229140107.GG2062@deprecation.cyrius.com>
	 <1167834727.3798.6.camel@xenpc.internal.licquia.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Jan 2007 08:35:56 -0500
Message-Id: <1167917756.6606.0.camel@xenpc.internal.licquia.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 09:32 -0500, Jeff Licquia wrote:
> I am running the complete lsb-runtime-test suite against the new kernels
> (as installed yesterday from the sid apt repo at
> http://kernel-archive.buildserver.net/debian-kernel), but I also did a
> run with just the msync test, which passed.  I will report the results
> for the full suite when they become available.

Those results are in.  No additional failures are caused by the new
kernels.

