Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWIQAMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWIQAMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 20:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWIQAMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 20:12:42 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:47036 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964879AbWIQAMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 20:12:41 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Chris Frost <chris@frostnet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4 oops: proc_pid_stat()
Date: Sun, 17 Sep 2006 10:12:38 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <7m4pg21bp6a1vci4jnql4r33rcg893q5is@4ax.com>
References: <20060916232402.GW13465@pooh.cs.ucla.edu>
In-Reply-To: <20060916232402.GW13465@pooh.cs.ucla.edu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 16:24:02 -0700, Chris Frost <chris@frostnet.net> wrote:

>[1.] One line summary of the problem:
>2.4.32 proc_pid_stat() repeatedly segfaults.
>
>[2.] Full description of the problem/report:
>2.4.32 kernel, after being up for a few days to a few weeks, repeatedly
>segfaults in proc_pid_stat(), triggered by w, ps, and other programs.

Problem not seen here, try 2.4.33.3 kernel?

Grant.
