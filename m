Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269291AbRHQAtg>; Thu, 16 Aug 2001 20:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269308AbRHQAtb>; Thu, 16 Aug 2001 20:49:31 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37899 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269274AbRHQArW>;
	Thu, 16 Aug 2001 20:47:22 -0400
Date: Thu, 16 Aug 2001 21:46:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bulent Abali <abali@us.ibm.com>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <20010816234639.E755@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33L.0108162146120.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Pavel Machek wrote:

> I'd call that configuration error. If swap-over-nbd works in all but
> such cases, its okay with me.

Agreed. I'm very interested in this case too, I guess we
should start testing swap-over-nbd and trying to fix things
as we encounter them...

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

