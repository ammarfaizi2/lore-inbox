Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWARPDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWARPDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWARPDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:03:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50829 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030333AbWARPDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:03:35 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20060117150307.7411.94174.sendpatchset@linux.site>
Subject: [patch 0/2] x86_64: pageattr cleanups
Date: Wed, 18 Jan 2006 16:03:32 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches remove __put_page from x86-64 pageattr.c and tidies
it up a bit. They've had some testing.

Nick
