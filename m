Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUJJRpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUJJRpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 13:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUJJRpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 13:45:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:19889 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268397AbUJJRpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 13:45:38 -0400
Date: Sun, 10 Oct 2004 10:45:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [BKPATCH] LAPIC fix for 2.6
In-Reply-To: <1097429707.30734.21.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
References: <1097429707.30734.21.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Oct 2004, Len Brown wrote:
>
> Hi Linus, please do a 
> 
> 	bk pull bk://linux-acpi.bkbits.net/26-latest-release

Ok, this version of the patch suddenly looks like a real bug-fix in that
it now makes the command line options "lapic"/"nolapic" a lot more
logical.

Pulled.

		Linus
