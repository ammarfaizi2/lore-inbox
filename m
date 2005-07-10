Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVGJSBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVGJSBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVGJSBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:01:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58795 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262003AbVGJSBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:01:43 -0400
Date: Sun, 10 Jul 2005 20:01:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [30/48] Suspend2 2.1.9.8 for 2.6.12: 607-atomic-copy.patch
Message-ID: <20050710180152.GB10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164423235@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164423235@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- 608-compression.patch-old/kernel/power/suspend2_core/compression.c	1970-01-01 10:00:00.000000000 +1000
> +++
> 608-compression.patch-new/kernel/power/suspend2_core/compression.c
                                         ~~~~~~~~~~~~~

suspend2_core looks like an extremely bad name for a directory... And
this is really plugin, not a core, no? Plus it would be nice to drop
non-essential stuff for initial submit, so that it is not *that* big
to review.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
