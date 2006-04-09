Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWDHUN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWDHUN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWDHUN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:13:57 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:7835 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751421AbWDHUN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:13:56 -0400
Date: Sun, 9 Apr 2006 04:11:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH rc1-mm 0/3] coredump: rfc
Message-ID: <20060409001059.GA95@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am unsure about this series. It adds some optimizations, but
complicates the code.

So I am asking for yours opinion not only about correctness, but
also about usefulness.

Oleg.

