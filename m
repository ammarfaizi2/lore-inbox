Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTJPUpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTJPUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:44:33 -0400
Received: from adsl-63-203-236-74.dsl.snfc21.pacbell.net ([63.203.236.74]:48848
	"EHLO mail.storlinksemi.com") by vger.kernel.org with ESMTP
	id S263181AbTJPUnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:43:35 -0400
From: "Alan Shih" <alan@storlinksemi.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Access MTD device from kernel module?
Date: Thu, 16 Oct 2003 13:43:34 -0700
Message-ID: <ODEIIOAOPGGCDIKEOPILKEEKDOAA.alan@storlinksemi.com>
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

I got stuck with a problem regarding a hardware driver (i.e. NIC driver)
trying to read a MTD partition.

I know I can export MTD's functions as kernel symbols but not sure if that's
the best way to do this.

TIA

Alan

