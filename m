Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277278AbRJDXzM>; Thu, 4 Oct 2001 19:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277274AbRJDXyy>; Thu, 4 Oct 2001 19:54:54 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:38665 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277270AbRJDXyv>;
	Thu, 4 Oct 2001 19:54:51 -0400
Date: Thu, 4 Oct 2001 20:55:08 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <9pir9h$ief$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0110042054490.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Linus Torvalds wrote:

> We (as in Linux) should make sure that we explicitly tell the disk when
> we need it to flush its disk buffers. We don't do that right, and
> because of _our_ problems some people claim that writeback caching is
> evil and bad.

Does this even work right for IDE ?

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

