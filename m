Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265273AbRFUWoA>; Thu, 21 Jun 2001 18:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265274AbRFUWnu>; Thu, 21 Jun 2001 18:43:50 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:37380
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S265273AbRFUWnr>; Thu, 21 Jun 2001 18:43:47 -0400
Date: Thu, 21 Jun 2001 19:43:28 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: <NFS@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>
Subject: Re: [NFS] NFS insanity
In-Reply-To: <shsae31yikx.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.32.0106211942580.322-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jun 2001, Trond Myklebust wrote:

>      > I haven't tried remounting yet to see what I get, but I don't
>      > see the problems on unpatched 2.4.2. I'll wait a bit to see if
>      > anyone has seen this. Anyone?
>
> Are you perchance using soft mounts?

No:

anthem:/mondo   /mondo  nfs defaults,rsize=3072,wsize=3072,suid,async 0 0

Async is on, but it's there by default IIRC, right?

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311

