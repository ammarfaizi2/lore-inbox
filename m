Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSAXLhO>; Thu, 24 Jan 2002 06:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287537AbSAXLhE>; Thu, 24 Jan 2002 06:37:04 -0500
Received: from mustard.heime.net ([194.234.65.222]:22755 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S287535AbSAXLgv>; Thu, 24 Jan 2002 06:36:51 -0500
Date: Thu, 24 Jan 2002 12:36:48 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error with Root-fs on NFS...
In-Reply-To: <shs1yggdm1b.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.30.0201241231460.29780-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well:
>       Is there a portmapper running on the server?

Yes

>       Is it accessible to the client (/etc/hosts.{allow,deny}, ipchains,...)?

Yes. No hosts.(allow|deny) setup. No ip(table|chain)s in kernel.

>       Is the portmapper advertising NFS version 2 (BTW: the syntax is 'v3' not 'nfsvers=3' on NFSroot)?

I've tried running default. The nfsvers=3 was just another attempt.

>       Is it advertising mountd version 1?

I beleive so... Isn't that the default?

As I mentioned earlier - NFS works from the same computer when booted from
hdd or floppy

regards

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

