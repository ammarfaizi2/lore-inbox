Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSHHCrJ>; Wed, 7 Aug 2002 22:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHHCrJ>; Wed, 7 Aug 2002 22:47:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:62212 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317279AbSHHCrI>; Wed, 7 Aug 2002 22:47:08 -0400
Date: Wed, 7 Aug 2002 23:50:35 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
In-Reply-To: <3D51DB52.6000200@verizon.net>
Message-ID: <Pine.LNX.4.44L.0208072350060.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44L.0208072350062.23404@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Anthony Russo., a.k.a. Stupendous Man wrote:

>  My info: Pentium III PC, kernel 2.4.19 vanilla, redhat 7.3, reiserfs.
>
> It's not pretty. Let me know what I can do to help.
>
> Aug  7 19:23:30 manic kernel:  kernel BUG at page_alloc.c:89!

> Aug  7 19:23:30 manic kernel: EIP:    0010:[<c012c331>]    Tainted: P

Which proprietary module have you loaded ?

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

