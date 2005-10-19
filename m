Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVJSMqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVJSMqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVJSMqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:46:10 -0400
Received: from spirit.analogic.com ([204.178.40.4]:2064 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750893AbVJSMqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:46:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 Oct 2005 12:46:07.0967 (UTC) FILETIME=[1362DEF0:01C5D4AB]
Content-class: urn:content-classes:message
Subject: Virtual Terminal problem in 2.6.13.4
Date: Wed, 19 Oct 2005 08:46:07 -0400
Message-ID: <Pine.LNX.4.61.0510190844510.4433@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Virtual Terminal problem in 2.6.13.4
Thread-Index: AcXUqxOBY8M5H18UQq+/Y+y0L5vapA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Previous versions would stop blanking the screen if I sent
the following escape-sequence out to the terminal:

 		[9;0]

Now, if this sequence is sent out, the terminal will blank
even when I am actively using the keyboard or mouse. This
shows that something broke in the virtual terminal driver.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
