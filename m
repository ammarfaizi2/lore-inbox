Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSHGEEF>; Wed, 7 Aug 2002 00:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSHGEEF>; Wed, 7 Aug 2002 00:04:05 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59918 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316824AbSHGEEE>; Wed, 7 Aug 2002 00:04:04 -0400
Date: Wed, 7 Aug 2002 01:07:32 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:113!
In-Reply-To: <20020807034831.2fa1823f.stephane.wirtel@belgacom.net>
Message-ID: <Pine.LNX.4.44L.0208070106110.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Stephane Wirtel wrote:

> nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002

> kernel BUG at page_alloc.c:113!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c012ed6e>]    Tainted: P
                               ^^^^^^^^^^

Can you trigger this bug without having the nvidia driver
write all over memory ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

