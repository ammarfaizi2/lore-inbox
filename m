Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUCKSkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUCKSkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:40:32 -0500
Received: from bitchx.linuxbox.co.uk ([66.54.199.224]:28875 "EHLO
	linuxbox.co.uk") by vger.kernel.org with ESMTP id S261635AbUCKSk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:40:29 -0500
Date: Thu, 11 Mar 2004 11:26:23 -0800 (PST)
From: pg smith <pete@linuxbox.co.uk>
To: linux-kernel@vger.kernel.org
Subject: LKM rootkits in 2.6.x
Message-ID: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any thoughts on the future of LKM rootkits in the 2.6 kernel branch ? In
the last few years I've become quite interested in them (from a defensive
point of view), but with the 2.6 kernel no longer exporting the syscall
table, intercepting system calls would appear to be a non-starter now. In
a perverse sort of way, i'm actually rather dissapointed: all that
learning gone to waste.

Cheers,

Pete

