Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbUKDS6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUKDS6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKDS5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:57:54 -0500
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:57039 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262351AbUKDS5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:57:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: QM_MODULES not implemented in 2.6.9
Date: Thu, 4 Nov 2004 10:57:29 -0800
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AE3@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: QM_MODULES not implemented in 2.6.9
thread-index: AcTCoCHNn/aZhrXQQIeiB0Mug16fDw==
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Yidng_wang@agilent.com>
X-OriginalArrivalTime: 04 Nov 2004 18:57:30.0633 (UTC) FILETIME=[22B91F90:01C4C2A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that this issue was there before but thought it was being taken care of since my Linux-2.6.2 kernel did not complain. Now I loaded Linux-2.6.9 and this QM_MODULES Function not implemented error pops up whenever I run module related command.

If I need update module patch, could someone tell which module patch I should apply? If something else is wrong, please advice. The kernel is configured to support module.

Thanks!

Eddie
