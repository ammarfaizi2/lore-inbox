Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUFSXYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUFSXYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUFSXYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:24:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:50104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264484AbUFSXY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:24:29 -0400
Date: Sat, 19 Jun 2004 16:23:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: florin@iucha.net, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
Message-Id: <20040619162322.1d15c2dd.akpm@osdl.org>
In-Reply-To: <200406200207.16399.dominik.karall@gmx.net>
References: <20040619210714.GD3243@iucha.net>
	<200406200117.38691.dominik.karall@gmx.net>
	<20040619160532.49934355.akpm@osdl.org>
	<200406200207.16399.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> > dmesg and .config, please.
>  attached

The dmesg output is incomplete.  You'll need to use `dmesg -s 1000000' to
get all of it.

I wish that would get fixed actually.  Seems a bit silly, and current
kernels permit querying of the ringbuffer size.
