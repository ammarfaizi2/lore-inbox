Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbSIZOxQ>; Thu, 26 Sep 2002 10:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbSIZOxQ>; Thu, 26 Sep 2002 10:53:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3231 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261309AbSIZOxP>; Thu, 26 Sep 2002 10:53:15 -0400
Date: Thu, 26 Sep 2002 11:58:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Lightweight Patch Manager <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux,v2
In-Reply-To: <Pine.LNX.4.44.0209260033420.7827-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0209261157291.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Thunder from the hill wrote:

> I'm aware of that possibility. What would you initialize it to, if not
> the list itself? (And BTW, anyone have a solution for slist_add()?)

If I were you, I'd take a large piece of paper and make
a drawing of what the data structure looks like and what
the various macros/functions are supposed to do.

That should make things easier.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

