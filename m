Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbRE2UvQ>; Tue, 29 May 2001 16:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbRE2Uu4>; Tue, 29 May 2001 16:50:56 -0400
Received: from dsl-dt-208-38-4-i185-cgy.nucleus.com ([208.38.4.185]:5138 "EHLO
	skaro.l-w.net") by vger.kernel.org with ESMTP id <S261793AbRE2Uut>;
	Tue, 29 May 2001 16:50:49 -0400
Date: Tue, 29 May 2001 14:50:34 -0600 (MDT)
From: lost@l-w.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: select() - Linux vs. BSD
In-Reply-To: <E154pWn-0004nN-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105291448540.19434-100000@skaro.l-w.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001, Alan Cox wrote:

> > 	In BSD, select() states that when a time out occurs, the bits passed to
> > select will not be altered.  In Linux, which claims BSD compliancy for this
> 
> Nope. BSD manual pages (the authentic ones anyway) say that the timeout value
> may well be written back but that this was a future enhancement and that users
> shoulsnt rely on the value being unchanged.

The reference was to the fdsets passed in if I read the original post
correctly.

William Astle
finger lost@l-w.net for further information

Geek Code V3.12: GCS/M/S d- s+:+ !a C++ UL++++$ P++ L+++ !E W++ !N w--- !O
!M PS PE V-- Y+ PGP t+@ 5++ X !R tv+@ b+++@ !DI D? G e++ h+ y?

