Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262016AbSIYVHH>; Wed, 25 Sep 2002 17:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSIYVHH>; Wed, 25 Sep 2002 17:07:07 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:25246 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262016AbSIYVHD>; Wed, 25 Sep 2002 17:07:03 -0400
Date: Wed, 25 Sep 2002 18:11:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux
In-Reply-To: <20020925205608.1BD86F@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0209251811080.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Lightweight Patch Manager wrote:

> This introduces single linked lists, as figured out by us four. Works
> fine with userspace test applications, should work fine with e.g. the
> scheduler. Breaks nothing. Must get adopted.

Where is the SLIST_HEAD macro and other goodies to be able
to use this thing in the same way we use list.h ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

