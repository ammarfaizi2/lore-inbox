Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVCZPog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVCZPog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVCZPo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:44:29 -0500
Received: from [213.147.175.99] ([213.147.175.99]:8079 "EHLO gollum.hlw.co.at")
	by vger.kernel.org with ESMTP id S261158AbVCZPoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:44:19 -0500
Subject: vanilla 2.6.11 Kernel Hangs after hlt checking
From: Michael Seydl <mingy@hlw.co.at>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 26 Mar 2005 16:44:14 +0100
Message-Id: <1111851854.9137.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 

i'm working on a P4 2.8 DualCore System with a vanilla 2.6.11.5 kernel. 

here's the problem kernel is hanging after the Checking for 'hlt'
instruction line. 

actually i've exprienced this happening with old systems but not with a
new one. 

haven't started debugging yet maybe someone has experinced the same
issue. 

greetz, 

mingy

p.s.: i know this mail doesn't sound linux geeky but i would be glad for
any response :)

