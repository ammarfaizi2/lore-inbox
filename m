Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSEDODz>; Sat, 4 May 2002 10:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSEDODy>; Sat, 4 May 2002 10:03:54 -0400
Received: from bnathan.remote.ics.uci.edu ([128.195.36.159]:60408 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S312998AbSEDODx>; Sat, 4 May 2002 10:03:53 -0400
Subject: Re: [patch] hpt374 support
To: akpm@zip.com.au (Andrew Morton)
Date: Fri, 3 May 2002 22:01:12 -0700 (PDT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        andre@linux-ide.org (Andre Hedrick),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <no.id> from "Andrew Morton" at May 03, 2002 02:08:21 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020504050112.1B44989BC9@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It has a problem with my 80 gigabyte Seagates - in UDMA133
> mode, writes are inexplicably slow.  I manually set UDMA100
> and it flies.

Hmmm... do 80GB Seagates even support UDMA133? I could be mistaken, but
as an owner of one, I'm pretty sure the answer is "no". In fact, I think
Maxtor's the only company making UDMA133 drives at this point in time.

-Barry K. Nathan <barryn@pobox.com>
