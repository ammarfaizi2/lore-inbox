Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293013AbSCKVDP>; Mon, 11 Mar 2002 16:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSCKVDF>; Mon, 11 Mar 2002 16:03:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:9733 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293013AbSCKVC4>;
	Mon, 11 Mar 2002 16:02:56 -0500
Date: Mon, 11 Mar 2002 18:02:38 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <3C8CEEFC.8137F5C0@redhat.com>
Message-ID: <Pine.LNX.4.44L.0203111802070.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Arjan van de Ven wrote:

> > And apparently we see that there is nothing special about them... Just don't
> > enable the write cache and all should be well with a timeout of 30 seconds.
>
> Quite a few controllers enable the write cache in their bootstrap before
> the OS gets involved.
> Just "don't enable" is not an option.

I've heard some talk about drives that turn it on
automatically when they get "too busy".

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

