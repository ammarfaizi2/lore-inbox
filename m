Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUCHJym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUCHJym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:54:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:57526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262441AbUCHJyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:54:35 -0500
Date: Mon, 8 Mar 2004 01:54:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-Id: <20040308015433.5424cc52.akpm@osdl.org>
In-Reply-To: <200403081504.30840.amitkale@emsyssoft.com>
References: <200403081504.30840.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> Here is kgdb for mainline kernel in three patches.

Thanks for working on this.

> This is a lite 
>  version of kgdb available from kgdb.sourceforge.net. I believe that all of us 
>  agree on this lite kgdb.

What is "lite" about it?  As in, what features have been removed?

>  It supports basic debugging of i386 architecture and debugging over a serial 
>  line. Contents of these patches are as follows:
> 
>  [1] core-lite.patch: architecture indepndent code
>  [2] i386-lite.patch: i386 architecture dependent code
>  [3] 8250.patch: support for generic serial driver

What is the story on kgdboe?
