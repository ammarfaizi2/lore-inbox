Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270927AbUJUUIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270927AbUJUUIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbUJUUED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:04:03 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:2052 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S270897AbUJUUAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:00:09 -0400
From: "Dave Hatton" <mail@davehatton.it>
To: <linux-kernel@vger.kernel.org>
Subject: shutdown -h causes laptop to reboot since kernel 2.6.9
Date: Thu, 21 Oct 2004 21:00:00 +0100
Organization: Starground Computers
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcS3qIuiAJkM/JjYRn+GqpwVI08SzA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Message-Id: <20041021200003.B515C252345@smtp.nildram.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

Since kernel 2.6.9, I'm finding "shutdown -g0 -h" now causes my HP nx7010
laptop to reboot rather than power down. 

No problems prior to 2.9.0.

Any pointers as to where to look to resolve this?

TIA

Dave Hatton


