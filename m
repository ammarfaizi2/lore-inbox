Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUBPXCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265984AbUBPWyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:54:40 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60868 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265992AbUBPWx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:53:57 -0500
Date: Mon, 16 Feb 2004 17:53:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       lhcs-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][2.6-mm] split drain_local_pages
In-Reply-To: <20040216224425.GB6628@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0402161752590.11793@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com>
 <20040216224425.GB6628@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Pavel Machek wrote:

> ...but code was passing cpu? The old version could not have compiled
> according to the patch..

No, it didn't compile, but the code wasn't enabled anyway, so that's ok.
