Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSFYV7e>; Tue, 25 Jun 2002 17:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSFYV7d>; Tue, 25 Jun 2002 17:59:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24593 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315946AbSFYV7d>; Tue, 25 Jun 2002 17:59:33 -0400
Date: Tue, 25 Jun 2002 18:57:39 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: rwhron@earthlink.net
cc: davej@suse.de, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
In-Reply-To: <20020625105837.GA12264@rushmore>
Message-ID: <Pine.LNX.4.44L.0206251856280.21905-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002 rwhron@earthlink.net wrote:

> dbench isn't scaling as well with the -rmap13b patch.

That probably means the system is fairer. Dbench "performance"
is at its best when the system is less fair.

I won't lecture you on why dbench isn't a good benchmark since
you must have heard that 100 times now ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

