Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVCDFwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVCDFwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCDFwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:52:37 -0500
Received: from [209.51.143.194] ([209.51.143.194]:24510 "EHLO
	server14.totalchoicehosting.com") by vger.kernel.org with ESMTP
	id S261500AbVCDFwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:52:33 -0500
Date: Fri, 04 Mar 2005 00:52:56 -0500
From: Leonid Petrov <nouser@lpetrov.net>
Reply-To: Leonid Petrov <nouser@lpetrov.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 ps/2 mouse is dead
Message-ID: <4227F7B8.nail79Z11S4KM@lpetrov.net>
User-Agent: nail 11.6(mod) 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server14.totalchoicehosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - verizon.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded from 2.6.10 to 2.6.11 using "make oldconfig" and my 
Logitech ps/2 mouse is dead. cat /dev/input/mice shows 
nothing. Nothing suspicios in /var/log/messages
The same mousce works fine with 2.6.10

Any clues?
