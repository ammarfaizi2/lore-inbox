Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319383AbSIKX2s>; Wed, 11 Sep 2002 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319385AbSIKX2s>; Wed, 11 Sep 2002 19:28:48 -0400
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:24501 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S319383AbSIKX2r>; Wed, 11 Sep 2002 19:28:47 -0400
Date: Thu, 12 Sep 2002 01:33:31 +0200 (CEST)
From: Gcc k6 testing account <caligula@cam029208.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: loadlin with 2.5.32+ : bootproblems
Message-ID: <Pine.LNX.4.44.0209120120570.13999-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ave  people

Has anyone used loadlin succesfull with 2.5.32 and higher?
>From 2.5.32 and higher my nfsroot setup won't work anymore.

The symptoms are:
While  loading the kernel with loadlin the dots indicating how far the 
loading process is are appearing on the screen. And then sudden...reboot.

At first I suspected nfsroot,so I deselected nfsroot in the .config. The 
idea was let loadlin load the kernel,see the boot message and wait until 
the kernel complains that he/she (?) can't find a valid root file system.
However,same symptoms.

Then I deselected preempt,no acpi. Still the same.
Athlon changed to i386. Still no joy.

Therefore,if anyone has succesfully used loadlin with 2.5.32 and higher. 
Please raise your hand and send me an email. Then I can scratch loadlin of 
the list of suspects.

Greetz Mu

p.s. 2.4.19 and 2.5.31 and lower works very well.
     just 2.5.32 and higher won't play with me.







