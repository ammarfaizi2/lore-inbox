Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130294AbQKNCDj>; Mon, 13 Nov 2000 21:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbQKNCDb>; Mon, 13 Nov 2000 21:03:31 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:31503 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S130294AbQKNCDW>; Mon, 13 Nov 2000 21:03:22 -0500
Date: Mon, 13 Nov 2000 17:33:12 -0800
From: Richard Henderson <rth@twiddle.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
Message-ID: <20001113173312.A1820@twiddle.net>
In-Reply-To: <8ui698$c2q$1@cesium.transmeta.com> <11198.973906134@ocs3.ocs-net> <8ui7le$c9a$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <8ui7le$c9a$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 05:33:34PM -0800, H. Peter Anvin wrote:
> AFAIK, I think Linus tried this once, but ran into bugs in gcc.
> We might very well try again in 2.5.

You'll definitely have to use a compiler later than gcc 2.95, since
there were in fact major bugs in this area.  I'd be interested in
hearing bug reports from someone trying with current cvs sources.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
