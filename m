Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312290AbSCYFpT>; Mon, 25 Mar 2002 00:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312291AbSCYFpI>; Mon, 25 Mar 2002 00:45:08 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25095 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312290AbSCYFoz>; Mon, 25 Mar 2002 00:44:55 -0500
Message-ID: <3C9EB8F6.247C7C3B@zip.com.au>
Date: Sun, 24 Mar 2002 21:43:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
        linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
In-Reply-To: <20020323140728.A4306@lucon.org> <3C9D1C1D.E30B9B4B@zip.com.au> <20020323221627.A10953@lucon.org> <3C9D7A42.B106C62D@zip.com.au> <20020324012819.A13155@lucon.org> <20020325003159.A2340@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> 
> And just to be clear ---- although in the past I've been really
> annoyed when glibc has made what I've considered to be arbitrary
> changes which have screwed ABI, compile-time, or link-time
> compatibility, and have spoken out against it --- in this particular
> case, I consider the fault to be purely the fault of the kernel
> developers, so there's no need having the glibc folks get all
> defensive....

So... Does the kernel need fixing? If so, what would you
recommend?

-
