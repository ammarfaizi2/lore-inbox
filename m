Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVAZIL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVAZIL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVAZIL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:11:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:47006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbVAZIL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:11:26 -0500
Date: Wed, 26 Jan 2005 00:11:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050126001113.30933eef.akpm@osdl.org>
In-Reply-To: <20050126080152.GA2751@suse.de>
References: <20050121161959.GO3922@fi.muni.cz>
	<1106360639.15804.1.camel@boxen>
	<20050123091154.GC16648@suse.de>
	<20050123011918.295db8e8.akpm@osdl.org>
	<20050123095608.GD16648@suse.de>
	<20050123023248.263daca9.akpm@osdl.org>
	<1106528219.867.22.camel@boxen>
	<20050124204659.GB19242@suse.de>
	<20050124125649.35f3dafd.akpm@osdl.org>
	<Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
	<20050126080152.GA2751@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> But the 2.6.11-rcX vm is still very
>  screwy, to get something close to nice and smooth behaviour I have to
>  run a fillmem every now and then to reclaim used memory.

Can you provide more details?
