Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936719AbWLCOdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936719AbWLCOdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 09:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936720AbWLCOdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 09:33:00 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:21005 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S936719AbWLCOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 09:33:00 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200612031432.kB3EWwgx008050@clem.clem-digital.net>
Subject: 2.6.19-git3 panic on boot
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sun, 3 Dec 2006 09:32:58 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
2.6.19-git3 panics on boot, missing the ./net/ipv6/ndisc.c patch
for problem introduced with r6-git12 or 2.6.19.
-- 
Pete Clements 
