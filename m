Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUCTUgp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbUCTUgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:36:45 -0500
Received: from smtpout1.compass.net.nz ([203.97.97.135]:749 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S263537AbUCTUgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:36:44 -0500
Date: Sun, 21 Mar 2004 09:38:55 +0000 (UTC)
From: s_kieu@hotmail.com
X-X-Sender: sk@darkstar.net
Reply-To: s_kieu@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: vmware and kernel 2.6 high cpu usage
Message-ID: <Pine.LNX.4.53.0403210932370.963@darkstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just notice vmware running in kernel 2.6.4 has much higher cpu usage than
2.4.23-aa2. 35% compared to 3 to 5% when vmware doesn't do anything. If I run
getright (a downloader for windoz) cpu usage is around 50% and many others progs
become a bit slugish. In 2.4.23-aa2 the usage is only 13 to 15%. the vmware
I used is at version 3. Is it because of the new vmmon modules? I notice the
size of the modules is much bigger though, for 2.6 it is around 100Kb for
2.4 I use the original vmware modules ; only 30Kb.

Is this behavior normal or should I do something to help the debuging?

best regards,

Steve Kieu
