Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSI3UKD>; Mon, 30 Sep 2002 16:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSI3UKD>; Mon, 30 Sep 2002 16:10:03 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:46317 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261311AbSI3UKC>; Mon, 30 Sep 2002 16:10:02 -0400
Date: Mon, 30 Sep 2002 17:15:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] procps 2.0.9
In-Reply-To: <3D989F25.F6605540@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209301714160.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Andrew Morton wrote:
> "Albert D. Cahalan" wrote:
> > Debian's code has been fully maintained for years. It is
> > available in CVS at SourceForge. Let us know what you think
> > of the new "top" program.
>
> Does it support the /proc/stat cleanups which I have queued,
> and the additional /proc/meminfo fields?

It doesn't seem support any of these things, but I have to
admit that the header of the new top program is more readable
than the old one due to not being completely in bold.

Looks like I'll have to port over some of the nice features
of the new top into the old one, or the other way around ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

