Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbUCOJ1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUCOJ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:27:42 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:6639 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262463AbUCOJ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:27:41 -0500
Date: Mon, 15 Mar 2004 10:27:35 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Hotplug with Kernel 2.6
Message-Id: <20040315102735.16ae4397.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I hotplug (or unplug) a USB mass storage device, I want to find out
which SCSI device (for example, /dev/sda or /dev/sdb) is (was) assigned
to that USB Device. Is it possible to do that with the help of the
variables which are passed to the hotplug scripts by the kernel?

Christoph
