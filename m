Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTLSCSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 21:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTLSCSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 21:18:50 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:25795 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265422AbTLSCSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 21:18:49 -0500
Date: Thu, 18 Dec 2003 18:18:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Diskstats inconsistancy between 2.4.23 & 2.6 was: Linux 2.6.0
Message-ID: <20031219021845.GG6438@matchmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while back there was a flamewar about adding diskstats to
/proc/partitions, and so /proc/diskstats was created, also it is a config
option in 2.4.  In 2.6, the stats are in /proc/partitions, but there is no
/proc/diskstats or config option.

Is /proc/diskstats going to be forward ported?
