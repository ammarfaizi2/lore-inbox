Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVL1R06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVL1R06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVL1R06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:26:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48553 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932539AbVL1R05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:26:57 -0500
Date: Wed, 28 Dec 2005 18:26:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.15-rc7-rt1
Message-ID: <20051228172643.GA26741@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.15-rc7-rt1 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this release mainly includes fixes from Steven Rostedt, for various 
problems with -rc5-rt4 - while i'm over in mutex-land ;)

Please re-report any bugs that remain.

to build a 2.6.15-rc7-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.15-rc7.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rc7-rt1

	Ingo
