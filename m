Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUCIEzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 23:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUCIEzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 23:55:51 -0500
Received: from [202.125.86.130] ([202.125.86.130]:33667 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261558AbUCIEzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 23:55:50 -0500
Content-class: urn:content-classes:message
Subject: disable partitioning!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 9 Mar 2004 10:22:32 +0530
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A9721287C8@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: disable partitioning!
Thread-Index: AcQFkiAUsH0yDd/ZTKSZbPorcKwdeQAACquQ
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are writing a block device driver for 2.4.x kernel.
I want to know how to indicate to the filesystem that our block driver does not support partitions.
I mean fdisk should not be allowed on disks supported by our block driver.

Regards,
-Jinu
