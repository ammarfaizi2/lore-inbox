Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbRBSEL4>; Sun, 18 Feb 2001 23:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130684AbRBSELq>; Sun, 18 Feb 2001 23:11:46 -0500
Received: from rhinocomputing.com ([161.58.241.147]:30478 "EHLO
	rhinocomputing.com") by vger.kernel.org with ESMTP
	id <S130442AbRBSELd>; Sun, 18 Feb 2001 23:11:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14992.40178.870916.407096@rhino.thrillseeker.net>
Date: Sun, 18 Feb 2001 23:11:30 -0500
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ip_conntrack error under 2.4.1-ac18
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting multiple messages like:

Feb 18 23:05:50 rhino kernel: ip_conntrack: maximum limit of 8184 entries exceeded
Feb 18 23:05:52 rhino last message repeated 2 times

while running nessus, with 100 simultaneous connections set, against a
company machine.  This is the first time I've observed this error.

Billy
