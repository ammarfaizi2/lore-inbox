Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130371AbQKWVoE>; Thu, 23 Nov 2000 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130327AbQKWVnz>; Thu, 23 Nov 2000 16:43:55 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:8374 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S130343AbQKWV0U>; Thu, 23 Nov 2000 16:26:20 -0500
Message-ID: <3A1D8471.FDDEED94@haque.net>
Date: Thu, 23 Nov 2000 15:56:17 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Alexander Viro <viro@math.psu.edu>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.21.0011232049210.2321-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still trying to reproduce the darn thing w/o the patch. No luck so
far.

Maybe I'll put some mission critical stuff on my machine. Then it'll pop
up like clock works. Thats the way everythign is supposed to work right?
=)

Tigran Aivazian wrote:
> However, I can't say that _without_ your patch the above did _not_
> survive. The corruptions usually come from real useful work and not from
> articfical tests (unfortunately)....

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
