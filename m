Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbUDBMoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUDBMoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:44:44 -0500
Received: from [202.125.86.130] ([202.125.86.130]:57274 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264033AbUDBMon convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:44:43 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: media removed indication!
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 2 Apr 2004 18:08:02 +0530
Message-ID: <1118873EE1755348B4812EA29C55A9721770B9@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: media removed indication!
Thread-Index: AcQYr1abAUNOMS10Q/eYa0WaRWjubw==
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: <kernelnewbies@nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are working on the removable media support for our disk driver. 

I have a couple of questions.

How do you ask the file system to stop sending buffers to our disk driver (request function) when the media is removed?

If a disk is already mounted when the media is removed is there a way to stop all IO and umount the disk automatically?

Any pointers on the same will be of great help.

Thanks,
-Jinu

