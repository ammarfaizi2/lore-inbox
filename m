Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTGHOgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTGHOgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:36:09 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:37128 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263281AbTGHOgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:36:08 -0400
From: "Alan Shih" <alan@storlinksemi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question regarding DMA xfer to user space directly
Date: Tue, 8 Jul 2003 07:50:44 -0700
Message-ID: <ODEIIOAOPGGCDIKEOPILIEODCLAA.alan@storlinksemi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a provision in MM for DMA transfer to user space directly without
allocating a kernel buffer?

TIA

Alan

