Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTDOXhJ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTDOXhJ 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:37:09 -0400
Received: from ohsmtp01.ogw.rr.com ([65.24.7.36]:52612 "EHLO
	ohsmtp01.ogw.rr.com") by vger.kernel.org with ESMTP id S262763AbTDOXhJ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:37:09 -0400
Message-ID: <000701c303a8$00682480$0200a8c0@satellite>
From: "Dave Mehler" <dmehler26@woh.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: i8253 count additional information
Date: Tue, 15 Apr 2003 19:37:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I found some info on my situation with the i8253 count too high problem
on my A7A266 motherboard, system rh9. It said adding:
noapic nohlt nodma
    should fix it, this did not work. Does anyone have a fix for this?
Thanks.
Dave.

