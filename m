Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVKHNWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVKHNWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVKHNWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:22:16 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7331 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965166AbVKHNWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:22:16 -0500
From: Greg Mitchell <greg.mitchell@emailman.cc>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: b44 network driver performance
Date: Tue, 8 Nov 2005 08:22:03 -0500
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511080822.03363.greg.mitchell@emailman.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Poor performance of b44 driver

Description: I'm getting a transfer rate of 3 MB/s between two machines on the 
same 100 Mbit lan. Using Broadcom's bcm4400 driver (which I believe is GPL), 
I get 10 MB/s.

Kernel Version: 2.6.13 (vanilla) on a P4


I noticed when this problem was occurring, I frequently see the network 
interface going down and then up again in the logs. Other than swapping out 
the modules, I haven't done any other testing - so let me know if you need 
anything else.


Greg Mitchell
