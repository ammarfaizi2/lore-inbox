Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292948AbSCDWeG>; Mon, 4 Mar 2002 17:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCDWd6>; Mon, 4 Mar 2002 17:33:58 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:30933 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S292948AbSCDWdq>;
	Mon, 4 Mar 2002 17:33:46 -0500
Date: Mon, 4 Mar 2002 23:34:03 +0100 (CET)
From: stephan@a2000.nu
X-X-Sender: kernel@ddx.a2000.nu
To: Mathieu Legrand <mathieu@accellion.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre2-ac2 || Linux 2.4.18-ac3, compilation error on
 SPARC
In-Reply-To: <20020304083236.GC3568@accellion.com>
Message-ID: <Pine.LNX.4.44.0203042332160.9623-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Mathieu Legrand wrote:

> Hello:
>
> I couldn't get the latest ac kernels to compile on a SUN sparc Ultra 10,
> even using the default configuration (arch/sparc64/defconfig).
>
same problem here
2.4.19-ac2 compiles ok
when applying the ac patches is fails on the ide.h

sun ultrasparc 10
redhat 6.2 (lot of updates)
gcc version :

Reading specs from /usr/lib/gcc-lib/sparc-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)


