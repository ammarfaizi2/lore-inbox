Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbSIXXSd>; Tue, 24 Sep 2002 19:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSIXXSd>; Tue, 24 Sep 2002 19:18:33 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:37035 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261844AbSIXXSc>; Tue, 24 Sep 2002 19:18:32 -0400
Date: Tue, 24 Sep 2002 20:23:20 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Peter Waechtler <pwaechtler@mac.com>
cc: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <B9100B20-D013-11D6-8873-00039387C942@mac.com>
Message-ID: <Pine.LNX.4.44L.0209242022410.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Peter Waechtler wrote:

> With Scheduler Activations this could also be avoided. The thread
> scheduler could get an upcall - but this will stay theory for a long
> time on Linux. But this is a somewhat far fetched example (for arguing
> for 1:1), isn't it?

Actually, the upcalls in a N:M scheme with scheduler activations
seem like a pretty good argument for 1:1 to me ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

