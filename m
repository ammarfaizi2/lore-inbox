Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSBUJ2l>; Thu, 21 Feb 2002 04:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290782AbSBUJ2b>; Thu, 21 Feb 2002 04:28:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7942 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290587AbSBUJ2X>;
	Thu, 21 Feb 2002 04:28:23 -0500
Message-ID: <3C74BDB4.5CD92998@mandrakesoft.com>
Date: Thu, 21 Feb 2002 04:28:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc2
In-Reply-To: <Pine.NEB.4.44.0202210924450.3462-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> as discussed in the thread of your 2.4.18-rc1 announcement (see [1] and
> [2]) 2.4.18 adds CONFIG_FB_TRIDENT but the code doesn't compile.  It's
> IMHO not a good a idea to add a new option that doesn't compile to a
> stable kernel. Please apply the patch below that disables this option as a
> workaround to 2.4.18:

No -- it's already marked with CONFIG_EXPERIMENTAL.

Thus if you are compiling this software, you do so at your own risk...

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
