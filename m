Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbTFQPgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbTFQPgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:36:18 -0400
Received: from [65.39.167.210] ([65.39.167.210]:896 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S264769AbTFQPgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:36:17 -0400
Date: Tue, 17 Jun 2003 11:47:20 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21] eth0: Transmit timed out, status fc664010, CSR12 00000000,
 resetting...
Message-ID: <Pine.LNX.4.44.0306171144330.405-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from dmesg: eth0: ADMtek Comet rev 17 at 0xdc00,
00:04:5A:55:FA:12, IRQ 11.

The card basically becomes *very* slow and fills the logs with:
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status fc664010, CSR12 00000000, resetting...


	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.


