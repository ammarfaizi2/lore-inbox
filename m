Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLMAJb>; Tue, 12 Dec 2000 19:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQLMAJV>; Tue, 12 Dec 2000 19:09:21 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:56540 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129226AbQLMAJQ>; Tue, 12 Dec 2000 19:09:16 -0500
Message-ID: <3A36B707.2EE4BDC8@haque.net>
Date: Tue, 12 Dec 2000 18:38:47 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Miles Lane <miles@megapathdsl.net>, Greg KH <greg@wirex.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <Pine.LNX.4.30.0012121522430.21906-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't you know it. I've patched my kernel with kdb and now I can't
get it to throw up.

Maybe it'll do it once this mail gets sent out like it did last time.

I'd prefer a dumper also. I went and grabbed LKCD but it didn't patch
cleanly against test12 so I decided against it.

dean gaudet wrote:
> 
> i've always been curious why none of the crash dump patches are default.
> an oops dumper alone would seem to be most useful.  (i know anything more
> would be unacceptable 'cause linus isn't into debuggers ;)
> 
> -dean
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
