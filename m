Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSFNPt5>; Fri, 14 Jun 2002 11:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317940AbSFNPt5>; Fri, 14 Jun 2002 11:49:57 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:9115 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317628AbSFNPtx>;
	Fri, 14 Jun 2002 11:49:53 -0400
Date: Sat, 15 Jun 2002 01:47:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: Re: [PATCH] make file leases work as they should
Message-Id: <20020615014738.07daaa2f.sfr@canb.auug.org.au>
In-Reply-To: <20020614222211.3169bb60.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002 22:22:11 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> This patch is against a recent BK tree (I wouldn't normally do this,
> but the fs/locks.c file has changed significantly since 2.5.21).

My mistake, this patch also applies to 2.5.21 (with some slight
offsets).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
