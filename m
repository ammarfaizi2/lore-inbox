Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUKEOWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUKEOWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUKEOWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:22:10 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:50392 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261634AbUKEORo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:17:44 -0500
To: linux-kernel@vger.kernel.org
cc: Ian.Pratt@cl.cam.ac.uk
Subject: Xen 2.0 Officially Released!
Date: Fri, 05 Nov 2004 14:17:43 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CQ4uN-0004PN-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Xen team are pleased to announce the release of Xen 2.0, the
open-source Virtual Machine Monitor.  Xen enables you to run
multiple operating systems images concurrently on the same
hardware, securely partitioning the resources of the machine
between them. Xen uses a technique called 'para-virtualization'
to achieve very low performance overhead -- typically just a few
percent relative to native.  This new release provides kernel
support for Linux 2.4.27/2.6.9 and NetBSD, with FreeBSD and Plan9
to follow in the next few weeks.

Xen 2.0 runs on almost the entire set of modern x86 hardware
supported by Linux, and is easy to 'drop-in' to an existing Linux
installation.  The new release has a lot more flexibility in how
guest OS virtual I/O devices are configured. For example, you can
configure arbitrary firewalling, bridging and routing of guest
virtual network interfaces, and use copy-on-write LVM volumes or
loopback files for storing guest OS disk images.  Another new
feature is 'live migration', which allows running OS images to be
moved between nodes in a cluster without having to stop
them. Visit the Xen homepage for downloads and documentation.

http://xen.sf.net



