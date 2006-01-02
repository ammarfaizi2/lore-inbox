Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWABETl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWABETl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 23:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWABETl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 23:19:41 -0500
Received: from xenotime.net ([66.160.160.81]:60552 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932320AbWABETl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 23:19:41 -0500
Date: Sun, 1 Jan 2006 20:20:20 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mtrr: 0xe4000000,0x4000000 overlaps existing
 0xe4000000,0x800000
Message-Id: <20060101202020.7ee7ae55.rdunlap@xenotime.net>
In-Reply-To: <1136173074.6553.2.camel@mindpipe>
References: <1136173074.6553.2.camel@mindpipe>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jan 2006 22:37:54 -0500 Lee Revell wrote:

> I got this in dmesg with 2.6.14-rc7 when I restarted X with
> ctrl-alt-backspace due to a lockup.  Is it a kernel bug or an X problem?

Is that a typo (2.6.14-rc7 or 2.6.15-rc7) ?


---
~Randy
