Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFNXo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 19:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTFNXo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 19:44:29 -0400
Received: from [65.39.167.210] ([65.39.167.210]:7297 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S261365AbTFNXo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 19:44:28 -0400
Date: Sat, 14 Jun 2003 19:56:01 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.71: undefined reference to `register_cpu_notifier'
Message-ID: <Pine.LNX.4.44.0306141954130.4066-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this on a fresh tree:

net/built-in.o(.init.text+0x209): In function `flow_cache_init':
: undefined reference to `register_cpu_notifier'
make: *** [.tmp_vmlinux1] Error 1


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

