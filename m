Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUGBMEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUGBMEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGBMEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:04:40 -0400
Received: from [202.125.86.130] ([202.125.86.130]:49638 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S263725AbUGBMEb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:04:31 -0400
Subject: Handling Signals in the driver
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Fri, 2 Jul 2004 17:32:19 +0530
Content-class: urn:content-classes:message
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348110387AB@mail.esn.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Handling Signals in the driver
Thread-Index: AcRgLGz7WKNutAtySjCYe9aP8H5xAQ==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Is there any method to send a signal from device driver to a Daemon
Process? 

Actually I have written a program to generate a daemon process. It was
working fine. I developed the application to send a signal to my daemon
to perform some action based on the signal. It was also working fine.
Now my intention is to send a signal from a device driver to the daemon
process. Is it possible? 

I am not very sure of how to achieve this. 
Please help me address this issue. 

Thank in advance,

Srinivas G
