Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbRE3UcQ>; Wed, 30 May 2001 16:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbRE3UcG>; Wed, 30 May 2001 16:32:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9737 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262027AbRE3Ubt>;
	Wed, 30 May 2001 16:31:49 -0400
Date: Wed, 30 May 2001 17:31:37 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Doug Bagley <doug@bagley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: calculation of ac_mem (in BSD accounting) misleading?
In-Reply-To: <15125.22457.579578.487040@ns.bagley.org>
Message-ID: <Pine.LNX.4.21.0105301730420.13062-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Doug Bagley wrote:

> Does it make sense to others that ac_mem should be changed to reflect
> the resident set size?

It does, but doesn't have all that much priority
at the moment. Feel free to send patches, though.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

