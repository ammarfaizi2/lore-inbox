Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbQLLNSG>; Tue, 12 Dec 2000 08:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQLLNR4>; Tue, 12 Dec 2000 08:17:56 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:63627 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129710AbQLLNRj>; Tue, 12 Dec 2000 08:17:39 -0500
Message-ID: <3A361E4F.C96117EC@haque.net>
Date: Tue, 12 Dec 2000 07:47:11 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 not liking high disk i/o
In-Reply-To: <Pine.LNX.4.30.0012120650060.9714-100000@viper.haque.net> <3A361A2F.6BE5D6B0@haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spoke too soon. It did it again while I was in X. Fetchmail/sendmail
was doing mail stuff. The two were also running the other times also so
its possible that this could be the trigger.

"Mohammad A. Haque" wrote:
> 
> Weird. I just booted from a test12 kernel I compiled (under test11) from
> completely clean sources
> and tried this again and no problems. I'm just gonna put this down as a
> fluke unless someone else someone else sees it or I lockup again.
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
