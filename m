Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWBTRIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWBTRIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWBTRIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:08:07 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:40975 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1161038AbWBTRIF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:08:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 20 Feb 2006 17:08:03.0870 (UTC) FILETIME=[36045BE0:01C63640]
Content-class: urn:content-classes:message
Subject: Missing file
Date: Mon, 20 Feb 2006 12:08:03 -0500
Message-ID: <Pine.LNX.4.61.0602201201200.4888@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Missing file
Thread-Index: AcY2QDYj1Wi/vIetSPyf86KU5CPikg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
Linux-2.6.15.4 fails to contain the file:
 	/usr/src/linux-2.6.15.4/drivers/pci/devlist.h

This contains product NAMES used to identity various PCI
devices when they are installed. What replaces this file?

The file existed up until at least linux-2.6.13.4 and
should not have been removed just because some audit
may have determined that it's "not in use." It is in
use by vendors which need to convert "Computerese" to
"Customer readable" stuff.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.49 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
