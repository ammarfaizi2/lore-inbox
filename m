Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSKVOe1>; Fri, 22 Nov 2002 09:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSKVOe1>; Fri, 22 Nov 2002 09:34:27 -0500
Received: from stingr.net ([212.193.32.15]:64271 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S264872AbSKVOe0>;
	Fri, 22 Nov 2002 09:34:26 -0500
Date: Fri, 22 Nov 2002 17:41:34 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CFT][PATCH] Ordered data mode on reiserfs for 2.4.20-rc2-ac3
Message-ID: <20021122144134.GI20701@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on Chris Mason patches for 2.4.20. -ac tree differ
because it lacks b_inode but using b_journal_head instead.

This patch may be wrong. So please peer review it. Thanks.
But it booted and passed some tests here :)))

ftp://stingr.net/pub/l/reiser-ordered-2.4.20-rc2-ac3.gz

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
