Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTJ2MKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 07:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTJ2MKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 07:10:34 -0500
Received: from wiggis.ethz.ch ([129.132.86.197]:24508 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S262033AbTJ2MKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 07:10:33 -0500
From: Thom Borton <borton@phys.ethz.ch>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Driver for Sony Memory Stick Controller (PCI)
Date: Wed, 29 Oct 2003 13:10:27 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310291310.27689.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everybody

I wonder whether/how it is possible to use my Memory Stick Slot of my 
Sony Vaio PCG-Z600NE. lspci gives me 

00:0d.0 Non-VGA unclassified device: Sony Corporation Memory Stick 
Controller (rev 01)

I have seem a couple of posts for similar devices that seem to be 
connected to the USB bus. They suggest using the usb-storage module 
to talk to the device. This obviously does not work here as it is a 
PCI device.

Any ideas?

Thanks a lot, Thom

-- 
Thom Borton
Switzerland

