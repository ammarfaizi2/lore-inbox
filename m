Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbTCRHSz>; Tue, 18 Mar 2003 02:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbTCRHSz>; Tue, 18 Mar 2003 02:18:55 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:13207 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262187AbTCRHSy>;
	Tue, 18 Mar 2003 02:18:54 -0500
Date: Tue, 18 Mar 2003 18:29:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, bcrl@redhat.com
Subject: Re: [PATCH][COMPAT] cleanups in net/compat.c and related files
Message-Id: <20030318182935.0aa53710.sfr@canb.auug.org.au>
In-Reply-To: <20030317.232218.91332148.davem@redhat.com>
References: <20030314180132.4696a7ca.sfr@canb.auug.org.au>
	<20030318181824.6f593d2c.sfr@canb.auug.org.au>
	<20030317.232218.91332148.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 23:22:18 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
>
>    From: Stephen Rothwell <sfr@canb.auug.org.au>
>    Date: Tue, 18 Mar 2003 18:18:24 +1100
>    
>    This also moves (almost) all if the compatibility stuff out of
>    linux/socket.h and into net/compat_socket.h
> 
> Why not include/net/compat.h?

Because compat_socket.h is already there ... I didn't create it.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
