Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbSJMWJ2>; Sun, 13 Oct 2002 18:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSJMWJ1>; Sun, 13 Oct 2002 18:09:27 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:39122 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261754AbSJMWJW>; Sun, 13 Oct 2002 18:09:22 -0400
Date: Sun, 13 Oct 2002 20:14:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.42: accessfs 3/3: access permission filesystem
In-Reply-To: <878z129fnz.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44L.0210132013330.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Olaf Dietsche wrote:

> This patch adds a new permission managing file system.

> +  # mount -t accessfs none /proc/access
> +  # chown www /proc/access/net/ip/bind/80
> +  # chown mail /proc/access/net/ip/bind/25

I like it.  This looks like a good way to run more daemons with
less priviledges.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

