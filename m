Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316467AbSEOSeq>; Wed, 15 May 2002 14:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316468AbSEOSep>; Wed, 15 May 2002 14:34:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54290 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316467AbSEOSep>; Wed, 15 May 2002 14:34:45 -0400
Date: Wed, 15 May 2002 15:33:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <20020515183004.GG27957@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0205151533060.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, William Lee Irwin III wrote:
> On Wed, May 15, 2002 at 10:00:25AM -0700, William Lee Irwin III wrote:
> > Wed May 15 09:58:22 PDT 2002
> > cpu  98583 0 8082 204779 9328
> >
> > It looks very constant, not sure if it should be otherwise.
>
> Not quite constant, just slowly varying:
>
> Wed May 15 11:30:47 PDT 2002
> cpu  2095183 0 158967 263950 20705

Well, with the amount of memory you have in the machine
I expect the time spent in idle and iowait to be fairly
limited during a repetitive kernel compile ;)

If everything "looks" normal in top and vmstat things
should be ok.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

