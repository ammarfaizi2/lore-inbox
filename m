Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318399AbSGRWWI>; Thu, 18 Jul 2002 18:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318402AbSGRWWI>; Thu, 18 Jul 2002 18:22:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21517 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318399AbSGRWVz>; Thu, 18 Jul 2002 18:21:55 -0400
Date: Thu, 18 Jul 2002 19:24:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: Robert Love <rml@tech9.net>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <Pine.LNX.4.30.0207181900390.30902-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44L.0207181923180.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Szakacsits Szabolcs wrote:

> And my point was that, this is only part of the solution
> making Linux a more reliable

I see no reason to not merge this (useful) part. Not only
is it useful on its own, it's also a necessary ingredient
of whatever "complete solution" to control per-user resource
limits.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

