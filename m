Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280332AbRJaRcC>; Wed, 31 Oct 2001 12:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280341AbRJaRbz>; Wed, 31 Oct 2001 12:31:55 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:48651 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S280332AbRJaRbs>; Wed, 31 Oct 2001 12:31:48 -0500
Date: Wed, 31 Oct 2001 09:32:24 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Larry McVoy <lm@bitmover.com>
cc: Rik van Riel <riel@conectiva.com.br>, Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Module Licensing?
In-Reply-To: <20011031092228.J1506@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0110310928130.14472-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Larry McVoy wrote:

> > Since your program, which happens to consist of one open
> > source part and one proprietary part, is partly a derived
> > work from the kernel source (by using kernel header files
> > and the inline functions in it) your whole work must be
> > distributed under the GPL.
>
> This is obviously incorrect, that would say that
>
> 	#include <sys/types.h>
>
> means my app is now GPLed.  Good luck enforcing that.

glibc is GLPL ... not GPL ...

-dean

