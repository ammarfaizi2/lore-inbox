Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265859AbUEUOCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUEUOCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 10:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265861AbUEUOCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 10:02:12 -0400
Received: from main.gmane.org ([80.91.224.249]:21690 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265859AbUEUOCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 10:02:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: thomas weidner <3.14159@gmx.net>
Subject: 4kstacks nvidia and x86-64.
Date: Fri, 21 May 2004 16:03:52 +0200
Message-ID: <pan.2004.05.21.14.03.52.299902@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9557666.dip.t-dialin.net
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since Fedora Core 2 is out,we all know, that the nvidia kernel module does
not work with 4kstacks. But on my x86-64 the nvidia module also freezes my
system (when starting X) with 2.6.6-bk5 and -bk6. i thought the  4kstack
patch is for i386 only. Are 4kstacks the reason for the freeze also on
x86-64? how can i disable them? (haven't such a option in config).

	thx Thomas

