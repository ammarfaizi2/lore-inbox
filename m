Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRHKVzf>; Sat, 11 Aug 2001 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268862AbRHKVzZ>; Sat, 11 Aug 2001 17:55:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:41740 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S268861AbRHKVzL>;
	Sat, 11 Aug 2001 17:55:11 -0400
Message-ID: <3B75A9B8.ECB8644@linux-m68k.org>
Date: Sat, 11 Aug 2001 23:55:04 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available.
In-Reply-To: <1904.997542180@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keith Owens wrote:

> None of the above methods handle dependency checking at all.  PPC makes
> an attempt but it is manually defined and is incomplete, no other arch
> even makes an attempt.

I'm wondering that you don't mention m68k, because we generate
dependencies...
(Has nothing to do with kbuild, I'm just curious. :) )

bye, Roman
