Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264691AbTFASOn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTFASOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:14:43 -0400
Received: from f6.sea2.hotmail.com ([207.68.165.6]:33796 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S264691AbTFASOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:14:42 -0400
X-Originating-IP: [216.244.221.2]
X-Originating-Email: [agusmdp@hotmail.com]
From: =?iso-8859-1?B?QWd1c3TtbiBIZXJyZXJh?= <agusmdp@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with scsi emulation
Date: Sun, 01 Jun 2003 15:28:06 -0300
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <Sea2-F6gKNZi2ghK57G0000ad30@hotmail.com>
X-OriginalArrivalTime: 01 Jun 2003 18:28:06.0841 (UTC) FILETIME=[8BCA5290:01C3286B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a customized 2.4.20 kernel (red hat 9) with scsi emulation, scsi 
cdrom & scsi generic support options enabled in .config and hdx-ide-scsi in 
lilo.conf.
apps as cdrecord or cdrdao take up all my cpu time (I have a duron 1.1 gz, 
kt133, 192mb sdram, 30 gb 5400 rpm hd).
in windows (with dma enabled) Nero doesn't take up any (or almost) cpu 
time...
is this an issue of the linux-kernel or a configuration problem?

_________________________________________________________________
Charla con tus amigos en línea mediante MSN Messenger: 
http://messenger.yupimsn.com/

