Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRASBPN>; Thu, 18 Jan 2001 20:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136582AbRASBO4>; Thu, 18 Jan 2001 20:14:56 -0500
Received: from donna.siteprotect.com ([64.26.0.144]:48392 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S131502AbRASBOd>; Thu, 18 Jan 2001 20:14:33 -0500
Date: Thu, 18 Jan 2001 20:14:38 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: Re: multi-queue scheduler update
In-Reply-To: <20010119015101.A6687@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.31.0101182011220.18129-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While I agree that this is probably only a win for very specialized tasks,
I'd be interested in seeing this patch implemented on a NUMA machine, with
one runqueue per node... anybody willing to try it? I don't have access to
one. How about from the Linux Scalability project at SGI? any comments?

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
