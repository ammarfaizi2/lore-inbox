Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLRENK>; Sun, 17 Dec 2000 23:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLRENA>; Sun, 17 Dec 2000 23:13:00 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:30142 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129226AbQLREMx>; Sun, 17 Dec 2000 23:12:53 -0500
Message-ID: <3A3D87A0.1E3585E7@haque.net>
Date: Sun, 17 Dec 2000 22:42:24 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rmlynch@best.com
CC: linux-kernel@vger.kernel.org
Subject: Re: test12 final, test13-pre3 freezing system
In-Reply-To: <3A3D85FC.FF1708C4@best.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

known problem with netfilter. I think someone is working on it.

Robert Lynch wrote:
> 
> I find that running these kernels (because of a netfilter modules
> compile error, didn't try test13-pre1 or 2) in X my entire system
> freezes, requiring a hard reboot.  With test12 final, suddenly
> the screen streaked, then froze.
> 
> No oops, just the freeze.

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
