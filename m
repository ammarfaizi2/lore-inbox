Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283283AbRK2Pvu>; Thu, 29 Nov 2001 10:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283291AbRK2Pvj>; Thu, 29 Nov 2001 10:51:39 -0500
Received: from ns.conwaycorp.net ([24.144.1.3]:50870 "HELO mail.conwaycorp.net")
	by vger.kernel.org with SMTP id <S283286AbRK2Pv2>;
	Thu, 29 Nov 2001 10:51:28 -0500
Date: Thu, 29 Nov 2001 09:51:07 -0600
From: Nathan Poznick <poznick@conwaycorp.net>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
Message-ID: <20011129095107.A17457@conwaycorp.net>
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Sven Heinicke:
> 
> The 2.4.16 kernel finally makes my clients happy with memory
> management.  The systems that froz up is a Dell of some sort or other
> with two 1Ghz Pentium IIIs and 4G of memory.  But, now I seems to be
> having ethernet problems.  With and eepro100 card:

I've encountered the same problem, with the same hardware setup (I
believe it's a Dell 2400, or something like that), on 2.4.14+xfs.  For
me it didn't lock up the entire machine however, it only seemed to
kill the network - I was able to reboot the machine cleanly once I got
to the console. (message from yesterday with the subject 'failed
assertion in tcp.c')  I too, am open to suggestions :-)

-- 
Nathan Poznick <poznick@conwaycorp.net>
PGP Key: http://drunkmonkey.org/pgpkey.txt

Curiosity has its own reason for existing.
-- Albert Einstein
