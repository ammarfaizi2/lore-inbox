Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267339AbUGNJZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267339AbUGNJZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUGNJZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:25:43 -0400
Received: from [202.125.86.130] ([202.125.86.130]:50357 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S267335AbUGNJZa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:25:30 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: CONFIG_MODVERSIONS disabled
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Wed, 14 Jul 2004 14:51:21 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811038E3B@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_MODVERSIONS disabled
Thread-Index: AcRpg+1oAnsmtIGAT/muCpVfomMmUg==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are using SuSe Linux 9.1 with kernel version 2.6.5-7.71. When we try
to compile our driver under this kernel it was showing the following
warning message.

WARNING: Symbol version dump
/usr/src/linux-2.6.5-7.71-obj/i386/default/Modules.symvers is missing,
modules will have CONFIG_MODVERSIONS disabled.

Actually it was previously worked with 2.6.4-54.1 kernel version. There
were no warning messages.

Am I missing any thing in the 2.6.5-7.71 kernel version? 

Any help great fully received.

Thanks in advance.

---srinivas g

 

