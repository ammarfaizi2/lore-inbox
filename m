Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSG2Ilr>; Mon, 29 Jul 2002 04:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSG2Ilr>; Mon, 29 Jul 2002 04:41:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:53258 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313508AbSG2Ilr>; Mon, 29 Jul 2002 04:41:47 -0400
Date: Mon, 29 Jul 2002 05:44:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] misc fixes
In-Reply-To: <E17Z4v0-0002io-00@starship>
Message-ID: <Pine.LNX.4.44L.0207290544180.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Daniel Phillips wrote:

> Sadly, it turns out that there are no possibilities for page table
> sharing when forking from bash.

Are you sure bash is using fork and not vfork ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

