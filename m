Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129681AbQJ0Q0X>; Fri, 27 Oct 2000 12:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQJ0Q0N>; Fri, 27 Oct 2000 12:26:13 -0400
Received: from kanga.kvack.org ([209.82.47.3]:43022 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129681AbQJ0QZ4>;
	Fri, 27 Oct 2000 12:25:56 -0400
Date: Fri, 27 Oct 2000 12:24:39 -0400 (EDT)
From: <kernel@kvack.org>
To: David Weinehall <tao@acc.umu.se>
cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test9 + LFS
In-Reply-To: <20001027181505.A2074@khan.acc.umu.se>
Message-ID: <Pine.LNX.3.96.1001027122341.27457B-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, David Weinehall wrote:

> On Fri, Oct 27, 2000 at 12:19:54PM -0400, Wakko Warner wrote:

> > That I do not know.  it's v 2.1.99  that came with debian in the past
> > week or so
> 
> Then it's compiled against the v2.2 kernel headers.

That explains why LFS isn't working then.  I strongly suggest that the
Debian glibc maintainers compile against 2.4 kernel headers or patch their
2.2 kernel headers to include the LFS stubs.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
