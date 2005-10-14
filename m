Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVJNQQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVJNQQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 12:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVJNQQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 12:16:00 -0400
Received: from adsl-static-1-49.uklinux.net ([62.245.36.49]:11716 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750775AbVJNQP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 12:15:59 -0400
To: linux-kernel@vger.kernel.org
From: John Rigg <lk@sound-man.co.uk>
Subject: 2.6.14-rc4-rt4
Message-Id: <E1EQSJt-0001Fp-4j@localhost.localdomain>
Date: Fri, 14 Oct 2005 17:22:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The header on my last post seems to have been mangled so here it
is again...

Ingo, I just tried the patch you posted in reply to Badari Pulavarty's
boot crash message. I get an error when trying to patch 2.6.14-rc4-rt4:

patching file arch/x86_64/kernel/vsyscall.c
patch: **** malformed patch at line 11: notrace

John
