Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUBYQW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUBYQUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:20:22 -0500
Received: from web21203.mail.yahoo.com ([216.136.130.22]:44220 "HELO
	web21203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261403AbUBYQTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:19:12 -0500
Message-ID: <20040225161911.22361.qmail@web21203.mail.yahoo.com>
Date: Wed, 25 Feb 2004 08:19:11 -0800 (PST)
From: Konstantin Kudin <konstantin_kudin@yahoo.com>
Subject: "Swap in" an entire process?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I have a question. Is there some way under linux to
"swap in" an entire process that got partially swapped
out?

 Basically, I want all the pages for a given PID
returned to RAM if they were paged out.

 And vice versa, is there a way to "swap out" a
process by some command?

 Thanks!

 Konstantin

__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
