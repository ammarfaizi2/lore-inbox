Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271277AbRHUC3X>; Mon, 20 Aug 2001 22:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271309AbRHUC3N>; Mon, 20 Aug 2001 22:29:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56338 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271277AbRHUC27>;
	Mon, 20 Aug 2001 22:28:59 -0400
Date: Mon, 20 Aug 2001 23:29:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <laughing@shared-source.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac8
In-Reply-To: <20010821014543.A27295@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L.0108202327110.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Alan Cox wrote:

> 2.4.8-ac8

> o	page reactivate correction			(Rik van Riel)

Whoops, this one wasn't really supposed to go in since
it interferes with ->writepage() like marcelo pointed
on the list out 30 seconds after I sent out the thing ;)

I'll send you a fix right away...

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

