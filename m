Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTHVL2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 07:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbTHVL2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 07:28:02 -0400
Received: from web41711.mail.yahoo.com ([66.218.93.128]:48253 "HELO
	web41711.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263108AbTHVKxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 06:53:54 -0400
Message-ID: <20030822105353.42347.qmail@web41711.mail.yahoo.com>
Date: Fri, 22 Aug 2003 03:53:53 -0700 (PDT)
From: SnowDog ro <snowdog_ro@yahoo.com>
Subject: .gnu.linkonce.this_module question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello
I tried to adapt an old module to the new format used
by 2.6 kernels
and i have a question about .gnu.linkonce.this_module
section.
It should contain a "module" structure from what i
understood in the
kernel sources but i can't quite figure out how can
there be a
difference of 1064 dwords between the storage location
for the init
subroutine and the storage location for the cleanup
routine.
The "module" structure itself is 96 bytes on my
machine. I have a
Pentium4 processor and linux kernel 2.6.0-test3.
How is this possible ?

Thank you
Snowdog


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
