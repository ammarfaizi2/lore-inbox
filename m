Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVCISI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVCISI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVCISF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:05:57 -0500
Received: from [194.243.27.136] ([194.243.27.136]:28874 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S262154AbVCISFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:05:48 -0500
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(62.94.206.179):. Processed in 3.120007 secs)
Date: Wed, 9 Mar 2005 19:05:13 +0100
From: Devel <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Subject: WDT on PCI
Message-Id: <20050309190513.13641db2.devel@integra-sc.it>
Organization: Integra Solutions
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i have a WDT-3 PCI watchdog card. It has also a serial port interface. All work fine with serial but on PCI i can't found the driver. 
If i do lspci i can't found nothing about WDT so i ask: If thereisn't the driver for a PCI card i can't have information from lspci?
Thank and sorry for my english :-)
