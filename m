Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbREXRdp>; Thu, 24 May 2001 13:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261564AbREXRdf>; Thu, 24 May 2001 13:33:35 -0400
Received: from ns2.cypress.com ([157.95.67.5]:13296 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S261561AbREXRd0>;
	Thu, 24 May 2001 13:33:26 -0400
Message-ID: <3B0D45D4.16565824@cypress.com>
Date: Thu, 24 May 2001 12:33:08 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/coda.h
In-Reply-To: <Pine.LNX.4.33L2.0105220924560.32368-100000@bodnar42.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming wrote:
> When compiling the kernel under FreeBSD, __KERNEL__ is defined, but
> __linux__ is not. I think this is an error on the part of the header file,
> because on non-Linux build environments, which would otherwise compile the
> Linux kernel correctly, do not have __linux__ defined.
> 
> However, not many people will probably find much use in compiling the
> kernel on other platforms, so if you think this isn't worth inclusion, I

hmmm...

building for:
SPARC under Solaris
PPC under BeOS
PA-RISC under HP-UX
M68k under HP-UX

I'd really like the last one.
I have a HP, M68k box I'd like to run
linux on and I've not seen a M68K distro
yet. But I haven't had time to try it yet
either.

	-Thomas
