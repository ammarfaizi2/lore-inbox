Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbTFLRjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTFLRjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:39:20 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:24713 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264933AbTFLRjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:39:00 -0400
Date: Thu, 12 Jun 2003 10:53:47 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Message-Id: <20030612105347.6ea644b7.akpm@digeo.com>
In-Reply-To: <1055438856.1202.6.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	<1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	<1052513725.15923.45.camel@andyp.pdx.osdl.net>
	<1055369326.1158.252.camel@andyp.pdx.osdl.net>
	<1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	<1055377253.1222.8.camel@andyp.pdx.osdl.net>
	<20030611172958.5e4d3500.akpm@digeo.com>
	<1055438856.1202.6.camel@andyp.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 17:52:45.0428 (UTC) FILETIME=[6DDFA340:01C3310B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> wrote:
>
> Dirty:               0 kB	Dirty:               4 kB <---

OK.  And are you using initrd as well?
