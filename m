Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTIKNzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbTIKNzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:55:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:63370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbTIKNzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:55:05 -0400
Date: Thu, 11 Sep 2003 06:54:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: richard.brunner@amd.com, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <20030911012708.GD3134@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is fragile and looks pointless.

What's wrong with the current status quo that just says "Athlon prefetch
is broken"?

		Linus

