Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTIRDtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 23:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbTIRDtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 23:49:31 -0400
Received: from [203.124.210.99] ([203.124.210.99]:47056 "EHLO
	rocklines.oyeindia.com") by vger.kernel.org with ESMTP
	id S262948AbTIRDt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 23:49:29 -0400
From: "msrinath" <msrinath@bplitl.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel NMI error
Date: Thu, 18 Sep 2003 09:22:34 +0530
Message-ID: <008601c37d98$4b7bc750$1d03000a@srinath>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <1063806072.12270.33.camel@dhcp23.swansea.linux.org.uk>
X-Information: Please contact the ISP for more information
X-Kaspersky: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I will wait and watch.

- Srinath

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: 17 September 2003 19:11
To: msrinath
Cc: 'Linux Kernel Mailing List'
Subject: RE: Kernel NMI error


On Mer, 2003-09-17 at 10:51, msrinath wrote:
> Thanks for the reply. This is the only time this has ever happened. How
can
> I make out if it is a memory error? Is there any way by which I can test
it?

If you can schedule down time for the machine run memtest86 on it for a
few hours to check. If not just see if it happens again I guess, if so
then think about testing the RAM


--
This message has been scanned for viruses and
dangerous content by Kaspersky on bpl Server, and is
believed to be clean.
bpl www.kaspersky.com
.


-- 
This message has been scanned for viruses and
dangerous content by Kaspersky on bpl Server, and is
believed to be clean.
bpl www.kaspersky.com
.

