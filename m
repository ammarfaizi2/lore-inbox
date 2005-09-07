Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVIGHdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVIGHdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVIGHdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:33:42 -0400
Received: from dark.beer.net ([204.145.225.20]:60686 "EHLO dark.beer.net")
	by vger.kernel.org with ESMTP id S1751162AbVIGHdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:33:42 -0400
From: Michael Glasgow <glasgow@beer.net>
Message-Id: <200509070733.j877XTwD008637@dark.beer.net>
Subject: causing iowait
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Sep 2005 02:33:29 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL54 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can anyone provide a hint for an easy way I can cause a process to
enter into and exit from an iowait (uninterruptible sleep) state
at will, without tinkering with the hardware, and without doing
something that will adversely affect other running processes?

This is not a kernel development question, but I'm betting some
kernel hacker knows how I can exploit a syscall to do this somehow.

Thanks,

-- 
Michael Glasgow <glasgow@beer.net>
