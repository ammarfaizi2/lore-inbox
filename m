Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318900AbSHWQEl>; Fri, 23 Aug 2002 12:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318903AbSHWQEl>; Fri, 23 Aug 2002 12:04:41 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:55049 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318900AbSHWQEk>; Fri, 23 Aug 2002 12:04:40 -0400
Date: Fri, 23 Aug 2002 13:08:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>,
       Federico Di Gregorio <fog@initd.org>, <faith@valinux.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel 830m backport (2.5 -> 2.4)
In-Reply-To: <1030116185.5911.17.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0208231307590.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2002, Alan Cox wrote:
> On Fri, 2002-08-23 at 15:30, Christoph Hellwig wrote:
>
> > Alan, is there any chance you could send marcelo the -ac drm code?
>
> It needs untangling from any rmap macro dependancies. Go ahead

Those "rmap macro dependencies" have been merged into 2.4 mainline
a few months ago ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

