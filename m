Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUGHPgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUGHPgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUGHPgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:36:48 -0400
Received: from [202.125.86.130] ([202.125.86.130]:35016 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264389AbUGHPgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:36:42 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Power Management in Linux
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 8 Jul 2004 21:03:31 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811038B3B@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Power Management in Linux
Thread-Index: AcRlAOysyB+cqPsmS2K2GZxWwSUz2Q==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Surendra I." <surendrai@esntechnologies.co.in>,
       "Subramanyam B." <subramanyamb@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have installed SuSe linux 9.1 on my HP Laptop. I was wondering if
Hibernation is supported in SuSe linux 9.1.  If yes, how to enable it?
Please instruct me the steps to enable Hibernation.

Also, I am developing a block driver for a PCI device under kernel
2.6.x.x. I would like to add PM features like Suspend, Wakeup and
Hibernation in Block driver. I have seen few character drivers
implementing PM features using pci_module_init()function. Will this
function work for Block devices? Also, there is no callback for
Hibernation, why?

Thanks
Srinivas G
