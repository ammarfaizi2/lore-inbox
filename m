Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUG0Fp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUG0Fp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUG0Fp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:45:58 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:59116 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266274AbUG0Fp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:45:56 -0400
Date: Tue, 27 Jul 2004 01:49:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Lynch <nathanl@austin.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] fixes for rcu_offline_cpu, rcu_move_batch (2.6.8-rc2)
In-Reply-To: <20040726170157.7f4b414c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407270137510.25781@montezuma.fsmlabs.com>
References: <1090870667.22306.40.camel@pants.austin.ibm.com>
 <20040726170157.7f4b414c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004, Andrew Morton wrote:

> oop.  We really should find some way to get more people to enable CPU
> hotplug.  We have a coverage problem.

You'll have to suck it in when i send the i386 implementation then ;) It
was on my queue including a bunch of fixes which needs testing before i send.
