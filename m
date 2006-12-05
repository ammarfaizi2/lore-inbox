Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031570AbWLEVZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031570AbWLEVZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031577AbWLEVZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:25:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:6126 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031572AbWLEVZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:25:02 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,501,1157353200"; 
   d="scan'208"; a="23515322:sNHT1417925844"
Date: Tue, 5 Dec 2006 12:59:09 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: -mm merge plans for 2.6.20, scheduler bits
Message-ID: <20061205125909.E5313@unix-os.sc.intel.com>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205211723.GA7169@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061205211723.GA7169@elte.hu>; from mingo@elte.hu on Tue, Dec 05, 2006 at 10:17:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:17:23PM +0100, Ingo Molnar wrote:
> > sched-decrease-number-of-load-balances.patch
> 
> this one goes away as per Ken's observation.

Not really. Ken posted a cleanup patch on top of the above patch. Ken pointed
one more cleanup which I will work on it and send it across in a day.

thanks,
suresh
