Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTGOGzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTGOGzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:55:08 -0400
Received: from ns.avalon.ru ([195.209.229.227]:36439 "EHLO smtp.avalon.ru")
	by vger.kernel.org with ESMTP id S263997AbTGOGzG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:55:06 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Partitioned loop device..
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Tue, 15 Jul 2003 11:10:45 +0400
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3840A9@frodo.avalon.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Partitioned loop device..
Thread-Index: AcNKoDYS/Tjw0E9QQL6ghxeWBjRT2A==
From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	Is there any (un)official patch for current stable (or
development) kernel that makes loop device partitioned? I found one on
the ftp://ftp.hq.nasa.gov/pub/ig/ccd/enhanced_loopback/ (it contains
port of Scyld's partition enhancements), but it seems still needs a fix.
In general I plan to use partitioned loop device to simulate real disks
in linux labs, possibly with a help from Stephen Tweedie's testdrive
fault simulator. I just wonder if partitionable/faultable loop device
planned in the future official kernels, or it will be better to write a
separate 'simulated disk' driver???

Thanks in advance,
Dimitry.
