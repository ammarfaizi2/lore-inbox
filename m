Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274741AbRIUCMe>; Thu, 20 Sep 2001 22:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274742AbRIUCMX>; Thu, 20 Sep 2001 22:12:23 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:18190 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S274741AbRIUCMQ>; Thu, 20 Sep 2001 22:12:16 -0400
Message-ID: <3BAA4ED5.EDEF3047@opersys.com>
Date: Thu, 20 Sep 2001 16:17:25 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] latency-profiling
In-Reply-To: <200109200609.f8K69uQ26778@mailc.telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> This patch works a little different from Robert Loves.
> Since it samples the execution location at ticks.
> It is possible to instrument an ordinary kernel too...

You could also try the Linux Trace Toolkit which would provide
you with much more accurate results and exact times instead of
samples. LTT is here: http://www.opersys.com/LTT

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
