Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUBPXIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUBPXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:08:34 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:56517 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265948AbUBPXFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:05:44 -0500
Date: Mon, 16 Feb 2004 18:05:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Martin Hicks <mort@wildopensource.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][2.6-mm] kernel/kmod.c kernel/kthread.c NR_CPUS fixes
In-Reply-To: <20040216225427.GF12142@localhost>
Message-ID: <Pine.LNX.4.58.0402161802100.11793@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0402161701240.11793@montezuma.fsmlabs.com>
 <20040216225427.GF12142@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Martin Hicks wrote:

>
> Hmm...I sent a similar patch to Andrew a couple hours ago.  I was really
> hoping there was a nicer way to fix this.

Offhand, no i don't know of a nicer way either. I was hoping the const
may help things.
