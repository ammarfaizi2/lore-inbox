Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWHBV6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWHBV6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWHBV6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:58:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50588 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932254AbWHBV6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:58:46 -0400
Date: Wed, 2 Aug 2006 14:58:24 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, Simon.Derr@bull.net, steiner@sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-Id: <20060802145824.99a5543b.pj@sgi.com>
In-Reply-To: <20060802143611.A19038@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0>
	<20060731071242.GA31377@elte.hu>
	<20060731090440.A2311@unix-os.sc.intel.com>
	<20060731095429.d2b8801d.pj@sgi.com>
	<20060731101542.A2817@unix-os.sc.intel.com>
	<20060801235752.28519bda.pj@sgi.com>
	<20060802143611.A19038@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> Paul, I will answer your questions on Suse bugzilla as that is a better
> forum than lkml.

Good idea.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
