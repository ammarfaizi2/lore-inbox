Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUJMGAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUJMGAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 02:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUJMGAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 02:00:30 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:6089 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268421AbUJMGA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 02:00:29 -0400
Message-ID: <9625752b041012230068619e68@mail.gmail.com>
Date: Tue, 12 Oct 2004 23:00:29 -0700
From: Danny <dannydaemonic@gmail.com>
Reply-To: Danny <dannydaemonic@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: mm kernel oops with r8169 & named, PREEMPT
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with the network driver r8169 and linux-2.6.9-rc4-mm1.  Same
thing happened with linux-2.6.9-rc3-mm3 (but also locked up). 
linux-2.6.8.1-mm4 didn't seem to have this problem.  This is very
repeatable, if this is an unknown issue let me know (CC please, not on
the list) and I will jump through the hoops to get a useful oops.
