Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310644AbSCMO6s>; Wed, 13 Mar 2002 09:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310645AbSCMO6j>; Wed, 13 Mar 2002 09:58:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:31756 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310644AbSCMO6V>;
	Wed, 13 Mar 2002 09:58:21 -0500
Date: Wed, 13 Mar 2002 11:58:08 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Peter Zaitsev <pz@spylog.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: MMAP vs READ/WRITE
In-Reply-To: <971737727409.20020313174814@spylog.ru>
Message-ID: <Pine.LNX.4.44L.0203131157210.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Peter Zaitsev wrote:

> RvR> On Wed, 13 Mar 2002, Peter Zaitsev wrote:
>
> >>   So I would say mmap is not really optimized nowdays in Linux and so
> >>   read() may be wining in cases it should not. May be read-ahead is
> >>   used with read and is not used with mmap.
>
> RvR> Both guesses are correct.
>
> Would you like to say me with rmap patches the situation should be
> different ?

That would be a bit premature since this part of the code
hasn't been touched by -rmap ;)

It is something that still needs fixing, though.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

