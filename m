Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRLQObG>; Mon, 17 Dec 2001 09:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279307AbRLQOa4>; Mon, 17 Dec 2001 09:30:56 -0500
Received: from ns.suse.de ([213.95.15.193]:8208 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279105AbRLQOag>;
	Mon, 17 Dec 2001 09:30:36 -0500
Date: Mon, 17 Dec 2001 15:30:32 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15389.49646.612985.293315@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112171523460.28670-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Trond Myklebust wrote:

> Nah. I hit this one myself just half an hour after 1 fired off my last
> mail.
> 'fattr' patch updated yet again...

Seems to do the trick. fsx has been running for about half hour so far
with no problems.

> However, 2 races + 4 bugs observed is already pretty much a record for
> a single program. Kudos to the NeXT developers...

Indeed. It's a really neat tool, we could use more like it.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

