Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUDAKyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbUDAKyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:54:14 -0500
Received: from [202.125.86.130] ([202.125.86.130]:53933 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262840AbUDAKyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:54:11 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Flash Media block driver problem!
Date: Thu, 1 Apr 2004 16:17:47 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A972176F98@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Flash Media block driver problem!
Thread-Index: AcQX1VN/O6SvpsBpROWks9mXeEpYyAAAQaGw
From: "Jinu M." <jinum@esntechnologies.co.in>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



cool; linux can use a GPL driver for such things...

[jinum] guess the question/clarification is not clear!
This is a driver for our own controller (PCI). Which is a PCI based
card.
This card is not based on the SCSI or IDE interface so how will some
other driver work for it unless we write ( or get it written sharing our
hardware spec) a driver for the interface?

-Jinu
