Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264406AbSIVQpr>; Sun, 22 Sep 2002 12:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264412AbSIVQpr>; Sun, 22 Sep 2002 12:45:47 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:56492 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264406AbSIVQpq>; Sun, 22 Sep 2002 12:45:46 -0400
Date: Sun, 22 Sep 2002 13:50:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Dan Kegel <dkegel@ixiacom.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Enforcing RLIMIT_RSS?
In-Reply-To: <15FDCE057B48784C80836803AE3598D53B88A6@racerx.ixiacom.com>
Message-ID: <Pine.LNX.4.44L.0209221350150.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Dan Kegel wrote:

> Rik has implemented this feature several times in the past...

> I need this feature on my embedded system, which uses 2.4.17 or so.
> Is the 2.4.0 patch the best place to start, or has anyone
> updated that patch for a more recent 2.4?

It's in 2.4-rmap...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

