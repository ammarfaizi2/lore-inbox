Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSIENcu>; Thu, 5 Sep 2002 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSIENcu>; Thu, 5 Sep 2002 09:32:50 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:30665 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317508AbSIENct>; Thu, 5 Sep 2002 09:32:49 -0400
Date: Thu, 5 Sep 2002 10:37:10 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Patrick Schaaf <bof@bof.de>
cc: "David S. Miller" <davem@redhat.com>, <rusty@rustcorp.com.au>,
       <ak@suse.de>, <laforge@gnumonks.org>,
       <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ip_conntrack_hash() problem
In-Reply-To: <20020905083932.F19551@oknodo.bof.de>
Message-ID: <Pine.LNX.4.44L.0209051036531.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Patrick Schaaf wrote:

> Sorry, but I was under the impression that code readability was worth
> the occasional static-global additional 4 bytes. I must have been
> mistaken.

If you want code readability, you could use a #define ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

