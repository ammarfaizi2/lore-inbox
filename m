Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSKEV1d>; Tue, 5 Nov 2002 16:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264926AbSKEV1d>; Tue, 5 Nov 2002 16:27:33 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:5074 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S264925AbSKEV1b>; Tue, 5 Nov 2002 16:27:31 -0500
Message-ID: <3DC8379E.20F9EA33@attbi.com>
Date: Tue, 05 Nov 2002 16:26:54 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O(1) CPU time accounting
References: <Pine.LNX.4.44L.0211051523280.3411-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> Hi Jim,
> 
> this incremental patch (over your O(1) CPU time patch) makes
> nice levels work again, though they are fairly steep now:
> 
> This might be a decent basis for an O(1) per-user fair
> scheduler, after some more balancing and cleaning up of
> excess code.

Hi Rik,

Your changes look reasonable. I will give them a try.

I'm hoping to get back to playing with scheduler fairness
patchs soon.  I made the mistake of starting a re-write of
Posix timers so it may be a few more days.

If anyone else is trying to follow this my patch is
archive here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103508412423719&w=2

Jim Houston - Concurrent Computer Corp.
