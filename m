Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTFMNPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 09:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265388AbTFMNPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 09:15:25 -0400
Received: from web20710.mail.yahoo.com ([216.136.226.183]:44900 "HELO
	web20710.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265387AbTFMNPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 09:15:24 -0400
Message-ID: <20030613132911.74745.qmail@web20710.mail.yahoo.com>
Date: Fri, 13 Jun 2003 06:29:11 -0700 (PDT)
From: Peter Rusedski <peter_istanbul@yahoo.com>
Subject: file operations in kernel module
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I am writing a kernel module for which I need to
access a file from within the module. I have source of
the same using normal open, read and close operations
already written.

My questions are
What is the best approach to do the same in kernel
module? 
Are there any constraints on maximum memory a module
can use.

Thanks in advance and apologies if I am at wrong
place.

Have a nice time,

Peter.

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
