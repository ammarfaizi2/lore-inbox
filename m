Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbUCOUv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUCOUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:51:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:24019 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262747AbUCOUvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:51:54 -0500
Date: Mon, 15 Mar 2004 12:53:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remove pmdisk from kernel
Message-Id: <20040315125357.3330c8c4.akpm@osdl.org>
In-Reply-To: <20040315195440.GA1312@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This removes pmdisk from kernel.

It would be unfortunate if Pat had more development planned or even
underway.  Have we checked?

> PS: Alternatively, I'm wiling to kill swsusp, rename pmdisk to "swap
> suspend", and submit patches to fix it. Its going to be slightly more
> complicated, through... 

People have suggested that I incorporate swsusp2.  Where does this fit into
things?
