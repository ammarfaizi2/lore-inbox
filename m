Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbTIIR1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTIIR1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:27:40 -0400
Received: from hal-4.inet.it ([213.92.5.23]:4792 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S264172AbTIIR07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:26:59 -0400
Message-ID: <00f201c376f8$231d5e00$beae7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Efficient IPC mechanism on Linux
Date: Tue, 9 Sep 2003 19:30:58 +0200
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

Hi all.
At the web page
http://web.tiscali.it/lucavera/www/root/ecbm/index.htm
You can find the results of my attempt in modifing the linux kernel sources
to implement a new Inter Process Communication mechanism.

It is called ECBM for Efficient Capability-Based Messaging.

In the reading You can also find the comparison of ECBM 
against some other commonly-used Linux IPC primitives 
(such as read/write on pipes or SYS V tools).

The results are quite clear.

Enjoy.
Luca Veraldi


----------------------------------------
Luca Veraldi

Graduate Student of Computer Science
at the University of Pisa

veraldi@cli.di.unipi.it
luca.veraldi@katamail.com
ICQ# 115368178
----------------------------------------
