Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUJSFAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUJSFAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUJSFAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:00:08 -0400
Received: from web50609.mail.yahoo.com ([206.190.38.248]:37789 "HELO
	web50609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267939AbUJSFAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:00:04 -0400
Message-ID: <20041019050002.5831.qmail@web50609.mail.yahoo.com>
Date: Mon, 18 Oct 2004 22:00:02 -0700 (PDT)
From: Jeba Anandhan A <jeba_career@yahoo.com>
Subject: initrd stuff & need of software layer for virtual to physical address translation ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i am newbie in kernel programming.i like to know about
initrd stuff by simple definition.

what is initrd.?
how it is used?

why root filesystem is mounted as readonly and later
read write?.

i hope MMU is responsible for converting virtual
address to physical address in hardware level.then why
we need it software level[ie kernel level .two level
page handling]


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
