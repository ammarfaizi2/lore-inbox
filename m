Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUI0UGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUI0UGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0UEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:04:16 -0400
Received: from minimail.digi.com ([204.221.110.13]:25210 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP id S267312AbUI0UDd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:03:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.8.1] drivers/char: New serial driver.
Date: Mon, 27 Sep 2004 15:03:32 -0500
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D774@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8.1] drivers/char: New serial driver.
Thread-Index: AcSkzRCoJ2xJTPw7RtOhhK8YhUxFDA==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <linux-kernel@vger.kernel.org>
Cc: <wenxiong@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am submitting a new serial driver for the 2.6 series of kernels.

Description:
Digi serial driver for the Digi Neo and Classic PCI serial port
products.

IBM has requested this submission into the Linux kernel.

The patch is quite large (300K uncompressed), so rather than attach it
I am submitting a link to our ftp site where the patch is located.

ftp://ftp1.digi.com/pub/patches/dgnc.patch

Signed-off-by: Scott H Kilau <scottk@digi.com>

Thanks
Scott Kilau
Digi International
