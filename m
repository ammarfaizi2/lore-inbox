Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSILQLZ>; Thu, 12 Sep 2002 12:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSILQLZ>; Thu, 12 Sep 2002 12:11:25 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:46493 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S316586AbSILQLY>; Thu, 12 Sep 2002 12:11:24 -0400
Date: Thu, 12 Sep 2002 13:16:02 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Rick Lindsley <ricklind@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
In-Reply-To: <3D804036.4C000672@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209121314440.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Andrew Morton wrote:

> b).  Let's get the kernel right and change userspace to follow.  We have
> another accounting patch which breaks top(1), so Rik has fixed it (and
> is feeding the fixes upstream).

Speaking of which, what happened to the iowait patch ?
Did you merge it with Linus or did it fall between the cracks ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

