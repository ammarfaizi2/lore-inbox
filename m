Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbULRIXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbULRIXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 03:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbULRIXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 03:23:50 -0500
Received: from news.suse.de ([195.135.220.2]:58545 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261393AbULRIXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 03:23:49 -0500
To: Mike Werner <werner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.10-rc3 1/4] agpgart: allow multiple backends to be initialized
References: <200412171255.59390.werner@sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Dec 2004 09:23:48 +0100
In-Reply-To: <200412171255.59390.werner@sgi.com.suse.lists.linux.kernel>
Message-ID: <p73vfb0c8vf.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Werner <werner@sgi.com> writes:

> Summary for the 4 patches.
> [1/4] Allow multiple backends to be initialized for agpgart
> [2/4] Run Lindent on generic.c
> [3/4] Patch drm code to work with modified agpgart api.
> [4/4] Patch framebuffer code to work with modified agpgart api.

I read your four patches quickly and they looked good to me.

-Andi

