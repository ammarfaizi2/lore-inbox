Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTKMSGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTKMSGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:06:51 -0500
Received: from rekin6.o2.pl ([212.126.20.11]:53177 "EHLO rekin.go2.pl")
	by vger.kernel.org with ESMTP id S264388AbTKMSGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:06:51 -0500
From: xkernel@o2.pl
To: linux-kernel@vger.kernel.org
Subject: =?iso-8859-2?Q?problem=20with=20DFE-530TX?=
Date: Thu, 13 Nov 2003 19:06:49 +0100
Content-Type: text/plain; charset="iso-8859-2";
Content-Transfer-Encoding: 8bit
X-Mailer: first3.pl WebMailv4.01. Usluga Poczty Elektronicznej dla o2.pl
X-Originator: 217.99.126.233
Message-Id: <20031113180649.5D48DD0BCC@rekin.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with VIA-RHINE driver using two D-LINK DFE-530TX cards. Problem occurs when I'v got compiled in kernel driver with enabled option "use MMIO". Kernel recognizes both cards assigns eth0, eth1 but when I try to set IP on eth1 it errors with message "device or resource busy". 
Problem occurs on 2.4.22 with no modules
With 2.4.19 from SuSe and modules both cards work fine...
anybody can help me ?
Greets
Przemys³aw Borkowski
