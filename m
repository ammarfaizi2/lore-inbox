Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUFLCqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUFLCqc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 22:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFLCqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 22:46:32 -0400
Received: from web90002.mail.scd.yahoo.com ([66.218.94.60]:62321 "HELO
	web90002.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264550AbUFLCqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 22:46:31 -0400
Message-ID: <20040612024630.74832.qmail@web90002.mail.scd.yahoo.com>
Date: Fri, 11 Jun 2004 19:46:30 -0700 (PDT)
From: read lkml <read_lkml@yahoo.com>
Subject: Question regarding userland stack on Linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

How big could a user land stack be on Linux? I
understand that the stack pointer grows donward from
3GB(typically).

How much can it grow downward? Can I control the size
of the stack? What is the default size of the stack?
If I outgrow this, do I get a segv? Is this
information i.e. (lowest stack address permissible)
available via current?


Thanks



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
