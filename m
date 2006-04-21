Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWDUGnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWDUGnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDUGnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:43:12 -0400
Received: from mail.suse.de ([195.135.220.2]:63938 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751199AbWDUGnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:43:11 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060301045901.12434.54077.sendpatchset@linux.site>
Subject: [patch 0/5] mm: improve remapping of vmalloc regions
Date: Fri, 21 Apr 2006 08:43:08 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I've added my fixes, and removed vmalloc_to_pfn as per
Christoph's suggestion.
