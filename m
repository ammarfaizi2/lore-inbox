Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbTCHBiq>; Fri, 7 Mar 2003 20:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbTCHBiq>; Fri, 7 Mar 2003 20:38:46 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:13328 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261970AbTCHBio>; Fri, 7 Mar 2003 20:38:44 -0500
Date: Sat, 8 Mar 2003 02:49:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Lang <david.lang@digitalinsight.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303071642420.1933-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0303080245350.32518-100000@serv>
References: <Pine.LNX.4.44.0303071642420.1933-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Mar 2003, David Lang wrote:

> The reason he gave back when the discussion was first started (months ago)
> was that klibc is designed to be directly linked into programs, and it was
> felt that this would not be possible with the GPL. In fact klibc was
> adopted instead of dietlibc speceificly BECOUSE of the license.

There is still the possibility to support multiple libc implementation, if 
you don't like dietlibc, you're still free to use klibc.

> while you could add an additional clause to the GPL to allow it to be
> linked into programs directly the I seriously doubt if the self appointed
> 'GPL police' would notice the issue and would expect that fears on the
> subject would limit it's use.

Could we at least try to not let this degenerate into a flamewar? Thanks.

bye, Roman

