Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbWE1FZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbWE1FZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 01:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWE1FZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 01:25:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51135 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965247AbWE1FZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 01:25:16 -0400
Date: Sun, 28 May 2006 06:25:15 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
Message-ID: <20060528052514.GQ27946@ftp.linux.org.uk>
References: <1148793123.7572.22.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148793123.7572.22.camel@homer>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 07:12:03AM +0200, Mike Galbraith wrote:
> Greetings,
> 
> I tried to boot 2.6.17-rc4-mm3 twice yesterday, and received the below
> both times.  Both times, the oops->panic occurred while X/KDE was
> starting.  KDE would not run thereafter, and had to be reinstalled.

Can you reproduce that with mainline?
