Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313593AbSDHJGq>; Mon, 8 Apr 2002 05:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313594AbSDHJGp>; Mon, 8 Apr 2002 05:06:45 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:17158 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313593AbSDHJGp>; Mon, 8 Apr 2002 05:06:45 -0400
Date: Mon, 8 Apr 2002 11:06:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: <1263.1018255806@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0204081105220.30722-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Apr 2002, Keith Owens wrote:

> >"touch include/linux/mm.h" doesn't cause a recompile of any object.
> 
> I have found a bug that is probably causing your problem.  Can you
> confirm that you are using a common source and object directory, i.e.
> no separate object tree?

Yes, so far I only tested this.

bye, Roman

