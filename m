Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUAQK0o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 05:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUAQK0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 05:26:44 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:40691 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S266022AbUAQK0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 05:26:43 -0500
Date: Sat, 17 Jan 2004 10:22:29 +0000
From: backblue <backblue@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: a7n8x-x
Message-Id: <20040117102229.4747e7f8.backblue@netcabo.pt>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2004 10:26:32.0554 (UTC) FILETIME=[607684A0:01C3DCE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For ppl with problems with a7n8x-x with chipset nforce2, that have problems with ide driver, and the machines hangs up, the solution it's upgrade the bios for the last release from the asus ftpd, i'm using version 1007, with 1005, that it's the default version, if we disable the suport in the kernel, for Nvidia id chipset, the machine works, but we dont have dma enable, and becomes impossible to work, and if we enable it, the machine hangs up every time, in 2.4 series it crashes less, but in 2.6.1, if i just compile anything the machine goes down, just upgrade the bios to this version, if not resolve, try to disable the APIC suporte on bios.
