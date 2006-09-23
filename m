Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWIWS4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWIWS4t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 14:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWIWS4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 14:56:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57038 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751421AbWIWS4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 14:56:48 -0400
Date: Sun, 24 Sep 2006 00:26:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH] RCU: various patches
Message-ID: <20060923185636.GA18156@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060923152957.GA13432@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923152957.GA13432@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 08:59:57PM +0530, Dipankar Sarma wrote:
> This patchset consists of various merge candidates that would
> do well to have some testing in -mm. This patchset breaks
> out RCU implementation from its APIs to allow multiple
> implementations, gives RCU its own softirq and finally
> lines up preemptible RCU from -rt tree as a configurable
> RCU implementation for mainline. Published earlier and
> re-diffed against -mm.
> 

Andrew,

I forgot that some of the 2.6.18-rc7-mm1 has a few patches
that have been merged. So, I should diff against that so that
including these in -mm will be easy. Patches will follow tomorrow.

Thanks
Dipankar
