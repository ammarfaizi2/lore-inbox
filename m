Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283445AbRLMGGD>; Thu, 13 Dec 2001 01:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283468AbRLMGFx>; Thu, 13 Dec 2001 01:05:53 -0500
Received: from rj.SGI.COM ([204.94.215.100]:25540 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S283445AbRLMGFg>;
	Thu, 13 Dec 2001 01:05:36 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Any arch specific changes to scripts directory? 
In-Reply-To: Your message of "Wed, 12 Dec 2001 23:59:43 MDT."
             <20011213055943.GB7669@0xd6.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 17:05:25 +1100
Message-ID: <24711.1008223525@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001 23:59:43 -0600, 
"M. R. Brown" <mrbrown@0xd6.org> wrote:
>On an somewhat-related subject, here are a couple of utility scripts that
>make it easier to use drop-in trees with various stock kernels.  These are
>used by linux-mips, linuxconsole (Ruby), and linuxsh developers, so it's
>assumed they'd be useful to anyone else who needs to build those kernels.

This facility and more is built into kbuild 2.5, which is going into
2.5 soon.  I don't see the point in adding this to 2.4 now, especially
since kbuild 2.5 can also run on 2.4 kernels.

http://sourceforge.net/projects/kbuild

