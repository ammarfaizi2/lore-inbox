Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUF1L0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUF1L0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 07:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUF1L0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 07:26:15 -0400
Received: from web50609.mail.yahoo.com ([206.190.38.248]:54901 "HELO
	web50609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264911AbUF1L0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 07:26:14 -0400
Message-ID: <20040628112614.98407.qmail@web50609.mail.yahoo.com>
Date: Mon, 28 Jun 2004 04:26:14 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: 2.6.x signal handler bug
To: Davide Libenzi <davidel@xmailserver.org>,
       Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406271551000.19865@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think so. Maybe the attached patch?

>No, the SIG_IGN check should be there ...

OK. I tested the patch and now the test program runs as it did under 2.4.

Thanks,
-Steve Grubb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
