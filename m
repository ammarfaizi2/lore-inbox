Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTEaIFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbTEaIFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:05:37 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:20945 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264208AbTEaIFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:05:36 -0400
From: Artemio <artemio@artemio.net>
To: linux-kernel@vger.kernel.org
Subject: Xeon processor support
Date: Sat, 31 May 2003 11:13:32 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305311113.32721.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a RH7.3-based system with recompiled original 2.4.20 kernel runing on 
dual 2.4GHz Xeon machine.

I'd like to know if there is a dedicated Xeon support in 2.4.21-pre? kernels.

The thing is I'm trying to compile RTLinux for this machine, but it fails to 
start. The main reason of this is wrong CPU type support in kernel.

I compiled 2.4.20 for Pentium 4, but new Xeons are a bit different. So is 
there a dedicated Xeon support in 2.4.21-pre? kernels?



Thanks.


Artemio.


