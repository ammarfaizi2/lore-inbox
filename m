Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSA2LFU>; Tue, 29 Jan 2002 06:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289492AbSA2LFK>; Tue, 29 Jan 2002 06:05:10 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:49158 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289484AbSA2LEy>;
	Tue, 29 Jan 2002 06:04:54 -0500
Date: Tue, 29 Jan 2002 09:04:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: John Weber <weber@nyc.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C5600A6.3080605@nyc.rr.com>
Message-ID: <Pine.LNX.4.33L.0201290902100.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, John Weber wrote:

> I would be happy to serve as patch penguin, as I plan on collecting all
> patches anyway in my new duties as maintainer of www.linuxhq.com.

> we have the hardware/network capacity to serve as a limitless queue of
> waiting patches for Linus.

Please don't just accumulate stuff.

It would be useful to know which of the patches still
applies against the most recent 2.2, 2.4 or 2.5 kernel,
so each patch gets some status fields:

1) applies against 2.2
2) applies against 2.4
3) applies against 2.5

4) was applied to 2.2
5) was applied to 2.4
6) was applied to 2.5

7) bitrotted patch, no longer applies and wasn't
   applied ... moved to 'old' queue

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

