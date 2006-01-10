Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWAJKCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWAJKCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWAJKCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:02:19 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14479 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932146AbWAJKCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:02:18 -0500
Date: Tue, 10 Jan 2006 15:32:11 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/5] rcu: join rcu_ctrlblk and rcu_state
Message-ID: <20060110100211.GB30159@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <43C165CE.AF913697@tv-sign.ru> <20060110002818.GD15083@us.ibm.com> <Pine.LNX.4.64.0601091641000.5588@g5.osdl.org> <20060110025439.GI14738@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110025439.GI14738@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 06:54:39PM -0800, Paul E. McKenney wrote:
> I believe that the original #2 is to be dropped, but that the patch Oleg
> submitted in:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113681388600342&w=2
> 
> may be needed.  I have added Vatsa to the CC to get his take on this.

The patch submitted in the above URL seems fine to me and I think we should
take it after Oleg does some basic testing.

- vatsa
