Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUBWQhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUBWQhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:37:32 -0500
Received: from [202.125.86.130] ([202.125.86.130]:53896 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261951AbUBWQha convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:37:30 -0500
Content-class: urn:content-classes:message
Subject: Device Driver for SMP
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 23 Feb 2004 22:06:46 +0530
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A97212812C@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Device Driver for SMP
Thread-Index: AcP6JyQcWthOvVyYSkuU0F4HzEOlMgABAkbw
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have developed a PCI device driver which works well on both MAC (yellow dog) and x86 (RedHat) architectures. 
Now we need to provide the support for SMP machine. What generic changes will have to be made to the driver to get it working on a SMP machine.

My first doubt is who takes care of the SMP support? Is it the kernel's job or the driver's job? 
As you can see I am not a guru at Linux device drivers, so I would be happy if you could provide me pointers or some good explanation on it.

Thanks a lot!
-Jinu

