Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276067AbRI1OGP>; Fri, 28 Sep 2001 10:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276065AbRI1OGF>; Fri, 28 Sep 2001 10:06:05 -0400
Received: from relay-4v.club-internet.fr ([194.158.96.115]:5767 "HELO
	relay-4v.club-internet.fr") by vger.kernel.org with SMTP
	id <S276063AbRI1OFy>; Fri, 28 Sep 2001 10:05:54 -0400
Message-ID: <3BB48494.404F15A8@club-internet.fr>
Date: Fri, 28 Sep 2001 16:09:24 +0200
From: Daniel Caujolle-Bert <segfault@club-internet.fr>
Reply-To: segfault@club-internet.fr
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Binary only module overview
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Arjan van de Ven wrote:
> 
> Hi,
> 
> I'm composing a list of all existing binary only modules,
> and I got to a list of 26 different modules; I undoubtedly forgot a few,
> so I hereby request feedback from people who know about modules I
> left out, so that I can complete the list. (I do not really care about
> modules that once existed for 2.0 or earlier and no longer exist for all
> intents and purposes)
> 
> Greetings,
>   Arjan van de Ven
> 
> Hardware drivers
> ----------------
[...]
> PCTel           - winmodem driver

	This one is not really 100% binary only, it use
an modified version of serial.c kernel driver. Of course
it's freely available.

Cheers.
-- 
73's de Daniel, F1RMB.

              -=- Daniel Caujolle-Bert -=- segfault@club-internet.fr -=-
                        -=- f1rmb@f1rmb.ampr.org (AMPR NET) -=-
