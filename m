Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWABDiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWABDiD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 22:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWABDiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 22:38:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2023 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932308AbWABDiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 22:38:02 -0500
Subject: mtrr: 0xe4000000,0x4000000 overlaps existing 0xe4000000,0x800000
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 22:37:54 -0500
Message-Id: <1136173074.6553.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this in dmesg with 2.6.14-rc7 when I restarted X with
ctrl-alt-backspace due to a lockup.  Is it a kernel bug or an X problem?

Lee

