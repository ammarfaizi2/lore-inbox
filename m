Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSI1OSH>; Sat, 28 Sep 2002 10:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261670AbSI1OSH>; Sat, 28 Sep 2002 10:18:07 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:62482 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261571AbSI1OSH>; Sat, 28 Sep 2002 10:18:07 -0400
Date: Sat, 28 Sep 2002 16:22:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Christoph Hellwig <hch@infradead.org>
cc: Lightweight Patch Manager <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
In-Reply-To: <20020928142319.A32048@infradead.org>
Message-ID: <Pine.LNX.4.44.0209281619320.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Sep 2002, Christoph Hellwig wrote:

> Please kill the sillz ifdef __KERNEL__ and convert to inlines.
> After that one could start to ctuallz review the implementation..

Add using a real name to the list, using pseudonyms is just silly and
patches from anonymous sources (without _very_ good reasons) are highly
suspicious.

bye, Roman

