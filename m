Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUIUOoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUIUOoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUIUOoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:44:39 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:8067 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S267702AbUIUOoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:44:34 -0400
Date: Tue, 21 Sep 2004 16:44:16 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: boot hangs since 2.6.9-rc2-bk6
Message-ID: <20040921144416.GA1361@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: TETs4GZvYeQHeg8NrXOxR6QyccC0CVe+sY18QJr6XSTZvMB+8f+iYG
X-TOI-MSGID: 49cf67e5-edc5-49c1-b355-aefc88e94af3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since linux-2.6.9-rc2-bk6 my smp system 
(Tyan S2665 mobo, 2x Xeon, I7505)
hangs during boot.

The last lines the boot screen shows are ..

..
CPU-Intel(R) Xeon(TM) CPU 2.4GHz stepping 07
per-CPU-timeslice cutoff: 1463.01
task migration cache decay timeout: 2ms
Booting processor 1/1 eip 2000
CPU1 irqstacks, hard=c063800 soft=c0634000

linux-2.6.9-rc2-bk5 works.

--
Regards Klaus
