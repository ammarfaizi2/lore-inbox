Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTKXTQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTKXTQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:16:12 -0500
Received: from web40902.mail.yahoo.com ([66.218.78.199]:36727 "HELO
	web40902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263609AbTKXTQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:16:09 -0500
Message-ID: <20031124191459.99375.qmail@web40902.mail.yahoo.com>
Date: Mon, 24 Nov 2003 11:14:59 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: What exactly are the issues with 2.6.0-test10 preempt?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw in Linus' 2.6.0-test10 announcement that preempt is suffering from some
problems and should not be used. However, I am currently running 2.6.0-test10
with CONFIG_PREEMPT=y and nothing has appeared yet. To see if the problem appeared
under stress, I started an A/V trailer playback with mplayer and then ran the
find command on both my home directory and the 2.6.0-test10 kernel source directory,
with the expected result - mplayer did not skip, neither find invocation broke,
and there were no nasty errors in dmesg.

So what exactly is the problem?

I can provide more system info on request.

TIA

Brad

=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
