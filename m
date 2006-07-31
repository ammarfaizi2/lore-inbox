Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWGaT3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWGaT3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWGaT3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:29:50 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14467 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030353AbWGaT3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:29:49 -0400
Date: Mon, 31 Jul 2006 12:30:34 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       stable@kernel.org, akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
Subject: Re: [stable] [PATCH] initramfs: Allow rootfs to use tmpfs instead of ramfs
Message-ID: <20060731193034.GU2654@sequoia.sous-sol.org>
References: <200607301808.14299.a1426z@gawab.com> <20060730175109.GA20777@kroah.com> <200607310003.56832.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607310003.56832.a1426z@gawab.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Al Boldi (a1426z@gawab.com) wrote:
> Being semantically the same, while not exhibiting ramfs pitfalls, makes it 
> suitable to be pushed into the -stable tree, IMHO.

You are failing to show how this is a critical type bugfix for -stable.
We are picky about -stable additions because we don't want to undermine
the value of the -stable tree.

thanks,
-chris
