Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUJWO0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUJWO0o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUJWO0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:26:44 -0400
Received: from outmx005.isp.belgacom.be ([195.238.2.102]:1671 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261189AbUJWO0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:26:43 -0400
Date: Sat, 23 Oct 2004 16:26:32 +0200 (CEST)
From: hans lambrechts <hans.lambrechts@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.10-rc1 doesn't boot
Message-ID: <Pine.LNX.4.58.0410231616120.6852@pc.home.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when i'm booting my box with kernel 2.6.10-rc1 i get this message:

	VFS: cannot open root device "sdb7" or unknown-block (8,32)

i've tried "root=8:32" w/o any improvement
kernel 2.6.9 is booting w/o complaining with "root=/dev/sdb7"
Has anybody seen this before?
i'm using lilo 22.3.4

Greetings,
Hans
