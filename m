Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSIORee>; Sun, 15 Sep 2002 13:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSIORee>; Sun, 15 Sep 2002 13:34:34 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:29365 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318138AbSIORee>; Sun, 15 Sep 2002 13:34:34 -0400
Date: Sun, 15 Sep 2002 14:39:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Axel Siebenwirth <axel@hh59.org>, Con Kolivas <conman@kolivas.net>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.34-mm4
In-Reply-To: <3D84C63E.76526EDE@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209151438030.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Andrew Morton wrote:
> Axel Siebenwirth wrote:

> > I have seen that it used more swap that usual.
>
> 2.5 is much more swaphappy than 2.4.  I believe that this is actually
> correct behaviour for optimum throughput.  But it just happens that
> people (me included) hate it.

Time for a corollary to "if you can't measure it, it doesn't exist":

"If you can't measure desktop performance, our method of development
 will ensure it won't exist"

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

