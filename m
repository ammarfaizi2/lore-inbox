Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315280AbSEGXLk>; Tue, 7 May 2002 19:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315394AbSEGXLj>; Tue, 7 May 2002 19:11:39 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:27920 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315280AbSEGXLh>; Tue, 7 May 2002 19:11:37 -0400
Date: Wed, 8 May 2002 01:11:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: thunder@ngforever.de, linux-kernel@vger.kernel.org
Subject: Re: pfn-Functionset out of order for sparc64 in current Bk tree?
In-Reply-To: <20020507.140848.29493830.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0205080108390.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, David S. Miller wrote:

> All of this is ignoring the fact that phys_base has to be subtracted
> from any physical address before applying as an index to mem_map on
> sparc64.

Not only on sparc64. :)
I was a bit in a hurry and forgot to mention that "detail"..., sorry. :)

bye, Roman


