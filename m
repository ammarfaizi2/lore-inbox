Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUBRDVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUBRDVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:21:11 -0500
Received: from web40705.mail.yahoo.com ([66.218.78.162]:54115 "HELO
	web40705.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262123AbUBRDVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:21:09 -0500
Message-ID: <20040218032105.10779.qmail@web40705.mail.yahoo.com>
Date: Tue, 17 Feb 2004 19:21:05 -0800 (PST)
From: Niranjan <niranjan_cs2905@yahoo.com>
Subject: Mapping /proc file to multiple module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I want to read the the /proc file created by kernel
module A from another kernel module B. The structure
is shared by both the module. 
In another way, can I have a /proc file shared between
many kernel modules so that I can pass parameters
between these module using /proc file ?
 
Regards,
-Niranjan


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
