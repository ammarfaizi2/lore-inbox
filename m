Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUIVUaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUIVUaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUIVUaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:30:22 -0400
Received: from mr02.conversent.net ([204.17.65.6]:63363 "EHLO
	mr02.conversent.net") by vger.kernel.org with ESMTP id S267400AbUIVUaM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:30:12 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Is there a user space pci rescan method?
Date: Wed, 22 Sep 2004 16:30:05 -0400
Message-ID: <E8F8DBCB0468204E856114A2CD20741F2C13D2@mail.local.ActualitySystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is there a user space pci rescan method?
thread-index: AcSg4vI0MkHVlOxRR+2x4HYtmpRDig==
From: "Dave Aubin" <daubin@actuality-systems.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
  Is there a user space or perhaps simple kernel module way to
rescan the pci bus?  I currently have a user mode program modify
the pci bus, but I can not push the user mode program to the
bios for reasons I can't get in to.  
  Currently I use this user mode program, then do a big hammer
approach of a reboot to get the kernel to see the pci device.  Is there
a nicer way of doing this?  Can someone kindly educate me.
 
Huge Thanks,
Dave:)
