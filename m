Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTJSScc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTJSScc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 14:32:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:12525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262033AbTJSScb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 14:32:31 -0400
Date: Sun, 19 Oct 2003 11:32:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-Id: <20031019113248.17eb0a5c.akpm@osdl.org>
In-Reply-To: <668910000.1066578207@[10.10.2.4]>
References: <20031015225055.GS17986@fs.tum.de>
	<20031015161251.7de440ab.akpm@osdl.org>
	<20031015232440.GU17986@fs.tum.de>
	<20031015165205.0cc40606.akpm@osdl.org>
	<20031018102127.GE12423@fs.tum.de>
	<649730000.1066491920@[10.10.2.4]>
	<20031018102402.3576af6c.akpm@osdl.org>
	<20031018174434.GJ12423@fs.tum.de>
	<20031018105733.380ea8d2.akpm@osdl.org>
	<668910000.1066578207@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
>  > It would take a quite a lot of work to measure this properly.  A simple A/B
>  > comparison doesn't cut it.
> 
>  So why are we changing it then? ;-)

It is very easy to demonstrate that it saves 300 kilobytes of memory.

