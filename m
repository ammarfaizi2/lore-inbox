Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274809AbTHKT1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273909AbTHKT0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:26:11 -0400
Received: from web41811.mail.yahoo.com ([66.218.93.145]:56434 "HELO
	web41811.mail.yahoo.com") by vger.kernel.org with SMTP
	id S273611AbTHKTYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:24:55 -0400
Message-ID: <20030811192453.51395.qmail@web41811.mail.yahoo.com>
Date: Mon, 11 Aug 2003 12:24:53 -0700 (PDT)
From: M M <mokomull@yahoo.com>
Subject: Kernel 2.6.0-test3: make modules; make modules_install problems
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have downloaded kernel 2.6.0-test3 sources twice (in
case of error) and the problem still persists.  'make
modules' compiles the modules to *.o, but 'make
modules_install' expects them to be *.ko.  Am I the
only one with this problem or does everyone have this
problem?

-MrM

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
