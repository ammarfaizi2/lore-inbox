Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUGFIAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUGFIAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 04:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUGFIAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 04:00:37 -0400
Received: from web8310.mail.in.yahoo.com ([203.199.122.10]:29012 "HELO
	web8310.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S263687AbUGFIAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 04:00:36 -0400
Message-ID: <20040706080030.35778.qmail@web8310.mail.in.yahoo.com>
Date: Tue, 6 Jul 2004 09:00:30 +0100 (BST)
From: =?iso-8859-1?q?Susheel=20Raj?= <susheel_nuguru@yahoo.co.in>
Subject: system calls-(query)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have been trying to understand how the system calls
are being made by applications and how the kernel
reacts to them...this is what i got into my brain....
when an application makes a system call ( for i386)
%eax register is filled with the system call number
and some other registers are to be given some
appropriate values..for example ..if i amke an exit ()
system call.. then its system call number "1" is
filled in %eax and the status code is filled in
%ebx...
 
so i want to know what are the requirements for other
systems calls to execute ...what all registers they
access..any documentation would be a great help.... 

________________________________________________________________________
Yahoo! India Careers: Over 50,000 jobs online
Go to: http://yahoo.naukri.com/
