Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUFBJsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUFBJsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 05:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUFBJsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 05:48:32 -0400
Received: from f17.mail.ru ([194.67.57.47]:24329 "EHLO f17.mail.ru")
	by vger.kernel.org with ESMTP id S261369AbUFBJsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 05:48:30 -0400
From: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	<adobriyan@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Abandoned code in include/linux/
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.64.46]
Date: Wed, 02 Jun 2004 13:48:29 +0400
Reply-To: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	  <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1BVSMH-0005JE-00.adobriyan-mail-ru@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grepping in 2.6.7-rc2 shows that nobody #include's several files

include/linux/802_11.h
include/linux/acpi_serial.h
include/linux/adb_mouse.h
include/linux/atapi.h
include/linux/fsfilter.h
include/linux/in_systm.h
include/linux/isdn_lzscomp.h
include/linux/mpp.h
include/linux/netbeui.h
include/linux/netfilter_ddp.h
include/linux/netfilter_ipx.h
include/linux/netfilter_x25.h

Should something from this list stay in kernel?

Alexey
