Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVALOkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVALOkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 09:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVALOkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 09:40:52 -0500
Received: from web53305.mail.yahoo.com ([206.190.39.234]:5035 "HELO
	web53305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261201AbVALOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 09:40:48 -0500
Message-ID: <20050112144047.51119.qmail@web53305.mail.yahoo.com>
Date: Wed, 12 Jan 2005 14:40:47 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: problem with syscall macro
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  i am writing a program which willcopy all the lines
from system log file /var/log/messages and put it in a
user log file 
i am using syslog with syscall3 but when i am using
write system cal it is not able to write anything 
do i have to add something more 
i have added the syscall3 macro for write too
do i have to do it for open system call also
i am little bit confuse with the kernel-user mode
switching concept too
could you please help me out
thans
sounak



________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
