Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281404AbRKTWFq>; Tue, 20 Nov 2001 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281410AbRKTWFh>; Tue, 20 Nov 2001 17:05:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58888 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281404AbRKTWFV>;
	Tue, 20 Nov 2001 17:05:21 -0500
Date: Tue, 20 Nov 2001 20:05:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Dan Maas <dmaas@dcine.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <037701c1720a$159ee9a0$1a01a8c0@allyourbase>
Message-ID: <Pine.LNX.4.33L.0111202004220.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Dan Maas wrote:

> > I bet they're getting mmap()d, like all mp3 programs seem to do
>
> Just a note here - I see much fewer buffer underruns and more consistent
> read-ahead/drop-behind behavior (i.e. no paging of other programs) when
> using plain read(), as opposed to mmap().

Consider this a VM bug, mmap() really should be more efficient.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

