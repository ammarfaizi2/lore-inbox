Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSGQT2M>; Wed, 17 Jul 2002 15:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSGQT2M>; Wed, 17 Jul 2002 15:28:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37384 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316573AbSGQT2L>; Wed, 17 Jul 2002 15:28:11 -0400
Date: Wed, 17 Jul 2002 16:31:04 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
In-Reply-To: <E17Ut3V-0004OY-00@starship>
Message-ID: <Pine.LNX.4.44L.0207171630450.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Daniel Phillips wrote:
> On Wednesday 17 July 2002 07:29, Andrew Morton wrote:
> > 11: The nightly updatedb run is still evicting everything.
>
> That is not a problem with rmap per se, it's a result of not properly
> handling streaming IO.

Umm, updatedb isn't exactly streaming...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

