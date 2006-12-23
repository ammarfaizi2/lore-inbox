Return-Path: <linux-kernel-owner+w=401wt.eu-S1753322AbWLWAjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbWLWAjD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 19:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbWLWAjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 19:39:03 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:12457 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbWLWAjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 19:39:02 -0500
Subject: Re: 2.6.19-rt14 slowdown compared to 2.6.19
From: Daniel Walker <dwalker@mvista.com>
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C0199950A@fmsmsx414.amr.corp.intel.com>
References: <9D2C22909C6E774EBFB8B5583AE5291C0199950A@fmsmsx414.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 16:38:22 -0800
Message-Id: <1166834302.14081.1.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-22 at 13:39 -0800, Chen, Tim C wrote:

> Wonder if you have any suggestions on what could cause the slowdown.  
> We've tried disabling CONFIG_NO_HZ and it didn't help much.

Did you compare PREEMPT_RT with vanilla PREEMPT ? Or one version of
PREEMPT_RT vs. another ?

Daniel

