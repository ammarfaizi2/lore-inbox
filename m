Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTJVPbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 11:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTJVPbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 11:31:43 -0400
Received: from math.ut.ee ([193.40.5.125]:10137 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263497AbTJVPbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 11:31:42 -0400
Date: Wed, 22 Oct 2003 18:31:35 +0300 (EEST)
From: Meelis Roos <mroos@math.ut.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031020203338.GJ6062@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.44.0310221830260.21711-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay.  Can you give the linuxppc-2.5 repo a shot on this machine?  It's
> at bk://ppc.bkbits.net/linuxppc-2.5 and
> rsync://source.mvista.com/linuxppc-2.5, for reference.  Let me know if
> it still boots at least and if it finds 64MB of memory again, it
> should..

It boots, tells the avail ram is 00400000 00800000 (should be 64M?)
and then the kernel hangs after starting Linux.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

