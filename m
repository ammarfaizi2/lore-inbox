Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266863AbUAXFLn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266865AbUAXFLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:11:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:44454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266863AbUAXFLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:11:42 -0500
Date: Fri, 23 Jan 2004 21:12:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2 kernel oops
Message-Id: <20040123211242.4dc0c770.akpm@osdl.org>
In-Reply-To: <4011AB0B.4030906@blueyonder.co.uk>
References: <4011AB0B.4030906@blueyonder.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> I get this on bootup, Athlon XP2200+
> =====================================
> Linux version 2.6.2-rc1-mm2 (root@barrabas) (gcc version 3.3.1 (SuSE 
> ...
> EIP is at test_wp_bit+0x36/0x90

oh crap, why does this thing keep breaking?  Please send your .config over,
thanks.

