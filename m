Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUHBNrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUHBNrt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUHBNrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:47:48 -0400
Received: from ozlabs.org ([203.10.76.45]:41613 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266532AbUHBNrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:47:33 -0400
Date: Mon, 2 Aug 2004 23:46:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: V Srivatsa <vatsa@in.ibm.com>, Nathan Lynch <nathanl@austin.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
Message-ID: <20040802134604.GL30253@krispykreme>
References: <20040802094907.GA3945@in.ibm.com> <20040802095741.GA4599@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802095741.GA4599@in.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Could it be that recent sched domain stuff broke CPU hotplug ?
> While testing cpu hotplug with some RCU changes, I got the following
> panic (while onlining).

Yeah, Im seeing the same thing.

Anton
