Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbSJMNef>; Sun, 13 Oct 2002 09:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSJMNef>; Sun, 13 Oct 2002 09:34:35 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:46723 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261521AbSJMNef>; Sun, 13 Oct 2002 09:34:35 -0400
Message-ID: <249381.1034516207360.JavaMail.nobody@web11.us.oracle.com>
Date: Sun, 13 Oct 2002 05:36:47 -0800 (GMT-08:00)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42: xircom_cb doesn't work
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is printed in the syslog...

Oct 13 01:00:41 dolphin cardmgr[601]: get dev info on socket 0 failed: Resource temporarily unavailable

There is also an oops on shutdown, the stack contains pci_remove_device; I can
 dig deeper into this only after October 18th.

--alessandro
