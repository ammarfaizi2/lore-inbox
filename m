Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWABEU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWABEU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 23:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWABEU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 23:20:27 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39658 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932320AbWABEU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 23:20:26 -0500
Subject: Re: mtrr: 0xe4000000,0x4000000 overlaps existing
	0xe4000000,0x800000
From: Lee Revell <rlrevell@joe-job.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060101202020.7ee7ae55.rdunlap@xenotime.net>
References: <1136173074.6553.2.camel@mindpipe>
	 <20060101202020.7ee7ae55.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 23:20:24 -0500
Message-Id: <1136175624.6553.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 20:20 -0800, Randy.Dunlap wrote:
> On Sun, 01 Jan 2006 22:37:54 -0500 Lee Revell wrote:
> 
> > I got this in dmesg with 2.6.14-rc7 when I restarted X with
> > ctrl-alt-backspace due to a lockup.  Is it a kernel bug or an X problem?
> 
> Is that a typo (2.6.14-rc7 or 2.6.15-rc7) ?
> 

Yep I meant 2.6.15-rc7.

