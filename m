Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUIWNT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUIWNT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUIWNT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:19:58 -0400
Received: from web8501.mail.in.yahoo.com ([202.43.219.163]:56423 "HELO
	web8501.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S268446AbUIWNTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:19:55 -0400
Message-ID: <20040923130446.48494.qmail@web8501.mail.in.yahoo.com>
Date: Thu, 23 Sep 2004 14:04:46 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: function installation at shutdown (reboot)
To: linux-kernel@vger.kernel.org
Cc: rddunlap@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
Thanks for your comments.
I tried to install a function using the fruntion
register_reboot_notifier(). Installation was
successfull but the installed function was not called
at reboot time. I used kernel version 2.4.20-8. Could
you please give me some light why this function is
does not get installed?

Thanks,
Manomugdha

=====
Manomugdha Biswas

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
