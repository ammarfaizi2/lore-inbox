Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTJMAdz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 20:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTJMAdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 20:33:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:40095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261276AbTJMAdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 20:33:54 -0400
Date: Sun, 12 Oct 2003 17:37:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Domen Puncer <domen@coderock.org>
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
Message-Id: <20031012173702.57eea934.akpm@osdl.org>
In-Reply-To: <200310130222.03175.domen@coderock.org>
References: <200310061529.56959.domen@coderock.org>
	<Pine.LNX.4.53.0310091904400.3679@montezuma.fsmlabs.com>
	<200310100155.53205.domen@coderock.org>
	<200310130222.03175.domen@coderock.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Domen Puncer <domen@coderock.org> wrote:
>
> Tried a bunch of 2.5.x kernels... no better.
>  Then i tried 2.4.22... and my nic still doesn't work fast.

There's some stuff in Documentation/networking/vortex.txt telling you how
to locate and run vortex-diag and mii-diag.

You might need to reprogram the eeprom using 3c90xx2.exe.
