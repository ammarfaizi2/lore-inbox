Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSAXMs0>; Thu, 24 Jan 2002 07:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287731AbSAXMsQ>; Thu, 24 Jan 2002 07:48:16 -0500
Received: from [213.225.90.118] ([213.225.90.118]:7687 "HELO lexx.infeline.org")
	by vger.kernel.org with SMTP id <S287710AbSAXMsD>;
	Thu, 24 Jan 2002 07:48:03 -0500
Date: Thu, 24 Jan 2002 13:46:50 +0100 (CET)
From: Ketil Froyn <ketil@froyn.net>
X-X-Sender: ketil@lexx.infeline.org
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which version of glibc?
In-Reply-To: <Pine.LNX.4.33.0201231042130.16094-100000@speech.corp.fedex.com>
Message-ID: <Pine.LNX.4.40L0.0201241341450.27930-100000@lexx.infeline.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Jeff Chua wrote:

> Should I upgrade to glibc-2.2.5 for linux kernel compilation?
>
> I'm on gcc-2.95.3, glibc-2.1.3

Unless I'm missing something, your version of glibc shouldn't matter.
glibc is not linked to the kernel. Your version of gcc, on the other hand,
is quite important. I guess you're ok with 2.95.3, and if you're not, I'm
sure you'll find out soon enough :)

Ketil

