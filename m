Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUHKLsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUHKLsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268030AbUHKLsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:48:15 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:44170 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268032AbUHKLsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:48:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu>
	<20040811074256.GA5298@elte.hu> <1092210765.1650.3.camel@mindpipe>
	<20040811082712.GB6528@elte.hu>
From: Linh Dang <linhd@nortelnetworks.com>
Organization: Null
Date: Wed, 11 Aug 2004 07:48:08 -0400
In-Reply-To: <20040811082712.GB6528@elte.hu> (Ingo Molnar's message of "Wed,
 11 Aug 2004 10:27:12 +0200")
Message-ID: <wn51xid99qf.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm not running the voluntary-preempt-* patches. but I do see some
long latencies with:

        vanilla 2.6.7+preempt-timing+defer-softirq

which were NOT reported here. Is it useful the report them?

Regards
-- 
Linh Dang
