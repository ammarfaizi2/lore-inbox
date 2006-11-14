Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965568AbWKNNBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965568AbWKNNBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965574AbWKNNA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:00:59 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:60386 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965568AbWKNNA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:00:59 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       magnus.damm@gmail.com, Horms <horms@verge.net.au>,
       Magnus Damm <magnus@valinux.co.jp>, Dave Anderson <anderson@redhat.com>,
       ebiederm@xmission.com, Jakub Jelinek <jakub@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Tue, 14 Nov 2006 22:00:57 +0900
Message-Id: <20061114130057.24180.34095.sendpatchset@localhost>
Subject: [PATCH 00/03] Elf: Various fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elf: various note fixes - the best of the 64-bit alignment patch

It seems like most people want 32-bit aligment on 64-bit platforms, so I've
given in and removed the alignment code but kept the fixes. The patches are
now refreshed to rc5 and updated to reflect the comments from Jakub, thanks!

/ magnus
