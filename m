Return-Path: <linux-kernel-owner+w=401wt.eu-S1947129AbWLHUQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947129AbWLHUQI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947141AbWLHUQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:16:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:58198 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947129AbWLHUQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:16:06 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 21:15:55 +0100
User-Agent: KMail/1.9.5
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Li, Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>
References: <200612080401.25746.ak@suse.de> <200612081810.29792.ak@suse.de> <20061208100004.D31153@unix-os.sc.intel.com>
In-Reply-To: <20061208100004.D31153@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612082115.55374.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 19:00, Siddha, Suresh B wrote:
> On Fri, Dec 08, 2006 at 06:10:29PM +0100, Andi Kleen wrote:
> > Yes please check the mainline git tree.
> 
> Ok. I think I am the culprit :(
> 
> Andi, Attached patch should fix the panic issue that Andrew encountered.
> Andrew, please confirm.

Thanks.
> 
> Andi, if you are applying Ingo's genapic changes and reverting this quirk
> changes in git, then there is no need to apply the appended patch.
> 
> Personally, I would like to go with Ingo's changes as it cleans up quite 
> a bit of code.

They need more testing/review first. Maybe later.

-Andi
