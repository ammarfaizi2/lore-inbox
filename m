Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTJQTx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTJQTx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:53:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:33462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263517AbTJQTxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:53:18 -0400
Date: Fri, 17 Oct 2003 12:53:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: cieciwa@alpha.zarz.agh.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 broken
Message-Id: <20031017125328.5348594d.akpm@osdl.org>
In-Reply-To: <20031017083641.19d27a20.rddunlap@osdl.org>
References: <Pine.LNX.4.58L.0310171508480.20432@alpha.zarz.agh.edu.pl>
	<20031017083641.19d27a20.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> | *** Warning: "set_special_pids" [fs/jffs/jffs.ko] undefined!
> 
> Andrew has a patch for this one in the -mm patchset.

It needs testing though.  Does anyone actually use jffs?

