Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUCSWc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUCSWc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:32:59 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:44727 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263137AbUCSWc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:32:56 -0500
Message-ID: <002501c40e02$1ff8f7b0$0716a8c0@carbon>
From: "Rob Roschewsk" <bangzoom@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6 newbie question RE: MODULES
Date: Fri, 19 Mar 2004 17:32:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all,
    Taking my first try at compiling a 2.6 kernel ..... 2.6.4 to be exact.

Got a clean compile ... and I'm building an initrd by hand just to kick the
tires .... I can't get my modules to load.

I've compiled and installed module-init-tools-3.0 .... and I copied
insmod.static to the initrd. When I boot and linuxrc runs on the initrd I
get this message:

Version magic '2.6.4 686 gcc-3.2' should be '2.6.4 SMP preempt PENTIUM III
gcc-3.2'

insmod: error inserting '/lib/scsi_mod.ko':-1 Invalid Module Format

I've been googling all day without a lot of luck. Any direct would be
appreciated.

Thanks,

--> Rob

