Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTJFKYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 06:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTJFKYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 06:24:19 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:20925 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261384AbTJFKYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 06:24:18 -0400
Date: Mon, 6 Oct 2003 12:24:15 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Message-ID: <20031006102415.GB7598@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031006082340.GA1135@matchmail.com> <1065428996.5033.5.camel@laptop.fenrus.com> <20031006083803.GB1135@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006083803.GB1135@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Oct 2003, Mike Fedyk wrote:

> config DEBUG_INFO
> 	bool "Compile the kernel with debug info"
> 	depends on DEBUG_KERNEL
> 	help
>           If you say Y here the resulting kernel image will include
> 	  debugging info resulting in a larger kernel image.
> 	  Say Y here only if you plan to use gdb to debug the kernel.
> 	  If you don't debug the kernel, you can say N.
> 
> "Larger kernel image" yeah, NO SHIT! ;)
> 
> Maybe something that says it may enlarge your kernel by 5-10 times would be
> nice...

Send a patch...

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
