Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319632AbSIMMyf>; Fri, 13 Sep 2002 08:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319631AbSIMMyf>; Fri, 13 Sep 2002 08:54:35 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:52136 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319632AbSIMMyd>; Fri, 13 Sep 2002 08:54:33 -0400
Date: Fri, 13 Sep 2002 09:59:04 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.5.34-mm3
In-Reply-To: <3D819132.C7171BD9@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209130955580.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Andrew Morton wrote:

> Rik, I didn't include the iowait patch because we don't seem to have
> a tarball of procps which supports it - the various diffs you have at
> http://surriel.com/procps/ appear to be in an intermediate state wrt
> cygnus CVS.

Umm no, the latest patch I put up yesterday is fully in sync
with the cygnus CVS tree ...

> The code is in experimental/iowait.patch.  Could we have a snapshot
> tarball of the support utilities please?

... but I've put up a snapshot, if that makes you happy ;)
The snapshot is of the latest procps code from procps CVS,
including your patch to top.

	http://surriel.com/procps/

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

