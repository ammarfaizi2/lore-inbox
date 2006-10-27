Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWJ0WPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWJ0WPE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWJ0WPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:15:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:982 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750767AbWJ0WPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:15:00 -0400
Subject: x86-64 with nvidia MCP51 chipset: kernel does not find HPET
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 18:15:01 -0400
Message-Id: <1161987301.27225.212.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 6 month old x86-64 machine with nvidia MCP51 chipset on which
the kernel does not detect the HPET.  According to HPET maintainer
Clemens Ladisch, this machine certainly has one, but it cannot be
enabled for lack of hardware documentation.

Is there anything I can do to help debug this?

Lee

