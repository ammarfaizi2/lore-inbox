Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319851AbSIND4p>; Fri, 13 Sep 2002 23:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319852AbSIND4p>; Fri, 13 Sep 2002 23:56:45 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:40880 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319851AbSIND4o>; Fri, 13 Sep 2002 23:56:44 -0400
Date: Sat, 14 Sep 2002 01:01:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.34-mm4
In-Reply-To: <3D82B5C3.229C6B1A@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209140059460.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Andrew Morton wrote:

> +iowait.patch
>
>  Instrumentation to show how much time is spent in disk wait.  (Doesn't
>  appear to come out in the new top(1) though?)

Will add it now that you're shipping it again.  Note that this
will be available as patches on my home page and from my bk
tree only for now.  I'll merge the needed patches into the main
procps tree once this stuff gets merged into the kernel.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

