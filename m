Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUHQRt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUHQRt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUHQRt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:49:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:43709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266539AbUHQRtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:49:24 -0400
Date: Tue, 17 Aug 2004 10:47:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: swsusp: fix default and merge upstream?
Message-Id: <20040817104745.683581dd.akpm@osdl.org>
In-Reply-To: <20040817111128.GA4164@elf.ucw.cz>
References: <20040817111128.GA4164@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Perhaps now is the right time to merge -mm swsusp up to Linus?

I suppose so.  The way to do that is for Pat to merge up the various
patches which are hanging around and then ask Linus to do the bk pull.

What's the testing status of the new code in bk-power.patch?
