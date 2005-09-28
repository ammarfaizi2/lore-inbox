Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVI1JKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVI1JKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVI1JKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:10:04 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:13896 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030227AbVI1JKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:10:02 -0400
Subject: Re: 2.6.14-rc2-rt2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com, emann@mrv.com,
       yang.yi@bmrtech.com
In-Reply-To: <20050926070210.GA5157@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 11:10:00 +0200
Message-Id: <1127898600.15670.37.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

-rt[45] do not compile with CONFIG_HOTPLUG_CPU. ktimers seem to mess up.
Not a biggie, don't need it anyway.

Peter

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

