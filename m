Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289619AbSAOTqE>; Tue, 15 Jan 2002 14:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289610AbSAOTp1>; Tue, 15 Jan 2002 14:45:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:18439 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289612AbSAOTpN>;
	Tue, 15 Jan 2002 14:45:13 -0500
Subject: Re: [PATCH] update: preemptive kernel for O(1) sched
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020113173222.D934@holomorphy.com>
In-Reply-To: <200201132325.g0DNPrm05503@zero.tech9.net>
	<1010965697.813.25.camel@phantasy>  <20020113173222.D934@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 14:48:36 -0500
Message-Id: <1011124116.8756.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

preempt-kernel for 2.5.2:
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.5

Note, again, this patch is not compatible with later O(1) patches due to
the load_balance changes.  I'll make the changes as they are merged into
2.5 proper.

No other changes in this release.

	Robert Love

