Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWHBVrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWHBVrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHBVrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:47:00 -0400
Received: from mga06.intel.com ([134.134.136.21]:27958 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932242AbWHBVq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:46:59 -0400
X-IronPort-AV: i="4.07,206,1151910000"; 
   d="scan'208"; a="101077354:sNHT55691146"
Date: Wed, 2 Aug 2006 14:36:11 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, vatsa@in.ibm.com, Simon.Derr@bull.net,
       steiner@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-ID: <20060802143611.A19038@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0> <20060731071242.GA31377@elte.hu> <20060731090440.A2311@unix-os.sc.intel.com> <20060731095429.d2b8801d.pj@sgi.com> <20060731101542.A2817@unix-os.sc.intel.com> <20060801235752.28519bda.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060801235752.28519bda.pj@sgi.com>; from pj@sgi.com on Tue, Aug 01, 2006 at 11:57:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 11:57:52PM -0700, Paul Jackson wrote:
> Suresh wrote:
> > Basically SLES10 has to backport all these patches:
> > 
> > sched: fix group power for allnodes_domains
> > sched_domai: Allocate sched_group structures dynamically
> > sched: build_sched_domains() fix
> 
> 
> A few questions on this, centered around the question of which dynamic
> sched domain patches we should backport to SLES10.
> 
> Readers not seriously interested in sched domains on 2.6.16.* kernels
> will probably want to ignore this post.

Paul, I will answer your questions on Suse bugzilla as that is a better
forum than lkml.

thanks,
suresh
