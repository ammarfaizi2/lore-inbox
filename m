Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTK1Jja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTK1Jja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:39:30 -0500
Received: from web40909.mail.yahoo.com ([66.218.78.206]:906 "HELO
	web40909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262086AbTK1Jj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:39:29 -0500
Message-ID: <20031128093929.13486.qmail@web40909.mail.yahoo.com>
Date: Fri, 28 Nov 2003 01:39:29 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Strange behavior observed w.r.t 'su' command
To: Mans Rullgard <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Rullgard,

Confirmed. I have a Red Hat 9 system running 2.6.0-test11 with glibc 2.3.2-82
and coreutils 4.5.3-19.0.2. Killing su with SIGKILL does put the keyboard into
unbuffered mode and does alternate the prompts. No error messages appear in dmesg.

Brad

=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
