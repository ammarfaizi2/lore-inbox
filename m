Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272314AbTHDXYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272315AbTHDXY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:24:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:5545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272314AbTHDXY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:24:26 -0400
Date: Mon, 4 Aug 2003 16:25:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stan Benoit <sab7@mail.ptd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic linux-2.6.0-test2
Message-Id: <20030804162546.69a16efa.akpm@osdl.org>
In-Reply-To: <20030804225407.GA270@mail.ptd.net>
References: <20030804225407.GA270@mail.ptd.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stan Benoit <sab7@mail.ptd.net> wrote:
>
> I'm planning on putting up a small web page to post logs,
>  .config files, results of test's on 2.6.0xxxx perhaps that
>  might help you all. 

The .config is what we'd be needing.

Also please test a more recent kernel, such as

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm4

or

ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots

There have been init-section fixes and a big sound update since
test2.
