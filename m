Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272363AbTHIOTB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTHIOTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:19:01 -0400
Received: from mail.suse.de ([213.95.15.193]:14093 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272363AbTHIOTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:19:00 -0400
Date: Sat, 9 Aug 2003 16:18:59 +0200
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0test3 currently broken on AMD64
Message-ID: <20030809141859.GC4539@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a short warning:

2.6.0test3 compiles, but at least the SMP kernel usually doesn't boot on x86-64. 
I will later release a new patchkit to fix that. Don't bother trying until then, 
unless you want to do debugging yourself.

-Andi

