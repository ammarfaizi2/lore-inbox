Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278742AbRKMUBG>; Tue, 13 Nov 2001 15:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRKMUA4>; Tue, 13 Nov 2001 15:00:56 -0500
Received: from anime.net ([63.172.78.150]:50188 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S278742AbRKMUAp>;
	Tue, 13 Nov 2001 15:00:45 -0500
Date: Tue, 13 Nov 2001 12:00:28 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>, <lars.nakkerud@compaq.com>
Subject: Re: Tuning Linux for high-speed disk subsystems
In-Reply-To: <Pine.LNX.4.30.0111131519440.933-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.30.0111131159120.796-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Roy Sigurd Karlsbakk wrote:
> After some testing at Compaq's lab in Oslo, I've come to the conclusion
> that Linux cannot scale higher than about 30-40MB/sec in or out of a
> hardware or software RAID-0 set with several stripe/chunk sizes tried out.

We managed >100mb/sec from a raid5 IDE setup, SMP athlon on Tyan S2460
with promise controllers.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

