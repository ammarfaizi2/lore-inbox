Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTHWX5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 19:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbTHWX5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 19:57:43 -0400
Received: from web14006.mail.yahoo.com ([216.136.175.122]:13607 "HELO
	web14006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263420AbTHWX5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 19:57:42 -0400
Message-ID: <20030823235741.41469.qmail@web14006.mail.yahoo.com>
Date: Sat, 23 Aug 2003 16:57:41 -0700 (PDT)
From: David Walser <luigiwalser@yahoo.com>
Subject: 2.6.0-test3 input device problems continue in test4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The issue reported here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/0482.html

is still not resolved in 2.6.0-test4.  It looks like
the bug was introduced by a patch from Alan Cox, from
looking at the test3 changelog.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
