Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132574AbQK3BQU>; Wed, 29 Nov 2000 20:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132573AbQK3BQJ>; Wed, 29 Nov 2000 20:16:09 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:36585 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S132557AbQK3BPy>; Wed, 29 Nov 2000 20:15:54 -0500
Message-ID: <3A25A324.4F5C9651@haque.net>
Date: Wed, 29 Nov 2000 19:45:24 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: rusty@rustcorp.com.au, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: another problem disappeared
In-Reply-To: <UTC200011300028.BAA150956.aeb@aak.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't have any problems masquerading w/ test11 here. How do you have
it setup?

Andries.Brouwer@cwi.nl wrote:
> 
> Recently I muttered a bit about the fact that
> with 2.4.0test11 masquerading, the first packet
> that was to be forwarded crashes the kernel. Always.
> Tonight I wanted to start investigating this more closely,
> but to my pleasant surprise 2.4.0test12pre3 does not have
> this problem. Progress.
> 
> (I am still a bit curious: did other people see this?
> Did someone fix a known problem with net(filter) or say /proc?
> It would be a pity if this disappeared by coincidence
> and appears again next month.)
> 
> Andries

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
