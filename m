Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTFPUbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFPUbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:31:14 -0400
Received: from svr7.m-online.net ([62.245.150.229]:8909 "EHLO
	svr7.m-online.net") by vger.kernel.org with ESMTP id S264252AbTFPUbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:31:12 -0400
Date: Mon, 16 Jun 2003 22:45:04 +0200
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
Subject: Can't unmount NFS - System freezes
Message-Id: <20030616224504.0132cc1b.florian.huber@mnet-online.de>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ML,
if I try to unmount a NFS-mounted directory my system freezes.
There is neither a error message nor a log entry.

I can't type anymore, but the NUM-Lock LED can still be switched
on/off. The host is also not ping-able.

I also tried different mount options (nfsvers=3, nfsvers=2, default or
even my former 2.4.x settings).

The NFS server is a 2.4.20 machine exporting with rw,async.
The client is using 2.5.71 (same with 2.5.70-mm9).

I'm sorry that I can't give you a more detailed description of the
problem. Perhaps you can give me some hints how to debug this.

TIA
	Florian Huber
