Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUBRFEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUBRFEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:04:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:16311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263491AbUBRFEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:04:05 -0500
Date: Tue, 17 Feb 2004 21:05:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: pavel@suse.cz, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net, ak@suse.de, george@mvista.com,
       jim.houston@ccur.com, mpm@selenic.com
Subject: Re: [PATCH][0/6] A different KGDB stub
Message-Id: <20040217210510.0c762c8b.akpm@osdl.org>
In-Reply-To: <200402181026.29813.amitkale@emsyssoft.com>
References: <20040217220236.GA16881@smtp.west.cox.net>
	<20040217143628.0aafd018.akpm@osdl.org>
	<20040217225241.GC666@elf.ucw.cz>
	<200402181026.29813.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> 9. Ethernet interface based on netconsole

This will be simplified when the netpoll infrastructure is merged up.
Hopefully that will happen very soon.
