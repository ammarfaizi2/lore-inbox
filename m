Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUIQXh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUIQXh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 19:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIQXh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 19:37:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:60394 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269043AbUIQXhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 19:37:52 -0400
Date: Fri, 17 Sep 2004 16:41:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6][0/14] DVB subsystem update
Message-Id: <20040917164135.7951c6d9.akpm@osdl.org>
In-Reply-To: <414AF2CA.3000502@linuxtv.org>
References: <414AF2CA.3000502@linuxtv.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@linuxtv.org> wrote:
>
> here comes a patchset consisting of 14 patches bringing the in-kernel 
> DVB subsystem in sync with the LinuxTV.org CVS driver.

I'm getting lots of rejects from these.  At the fifth patch I gave up.  The
rejects appear to be against stock 2.6.9-rc2.

Please regenerate these patches and double-check that they apply to latest
-linus tree.  Or against next -mm if they are dependent upon Gerd's
patches:

v4l-msp3400-cleanup.patch
v4l-tuner-update.patch
v4l-bttv-update.patch
v4l-dvb-cx88-driver-update.patch

