Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUCIOjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 09:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUCIOjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 09:39:16 -0500
Received: from [202.125.86.130] ([202.125.86.130]:30344 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261959AbUCIOjP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 09:39:15 -0500
Content-class: urn:content-classes:message
Subject: auto mount disk!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 9 Mar 2004 20:05:54 +0530
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A972176349@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: auto mount disk!
Thread-Index: AcQF276TI455kvXxSXaVAWD5szM/tgACAjzA
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have question about auto mounting of block devices.

I have a Red Hat 7.3 running 2.4.18-3 kernel. I have X Windows installed. When I am in GNOME and I open the CD tray and insert a CD the CD is auto mounted and a disk icon appears on the desktop. But when I am in KDE and I insert a CD I find that the CD is NOT automatically mounted.

Now then my question here is does the driver need to support some signaling mechanism to indicate to the upper layers (file system) that a disk is inserted. Is auto mounting a feature that block device driver should be aware off. Any pointer on this with respect to the driver side will be more than helpful.

Thanks in advance!
-Jinu
