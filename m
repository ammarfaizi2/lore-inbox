Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUGIQjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUGIQjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUGIQjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:39:21 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:33251 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S265074AbUGIQif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:38:35 -0400
Subject: Re: 2.6.7-mm7
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1089384059.1742.3.camel@teapot.felipe-alfaro.com>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	 <1089369159.3198.4.camel@paragon.slim>
	 <1089384059.1742.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1089391222.3205.3.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 18:40:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 16:40, Felipe Alfaro Solana wrote:
> Have you tried reverting bk-usb? 2.6.7-mm7 won't work for me without
> reverting it.

Just tried it (reverted bk-usb.patch), still no go. Maybe PCI related?
> On Fri, 2004-07-09 at 12:32 +0200, Jurgen Kramer wrote:
> > On Fri, 2004-07-09 at 08:50, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> > > 
> > My EHCI controller still won't come back to life. I have tried 
> > various boot options to no avail. I still gives:

JK


