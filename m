Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313082AbSDLAJx>; Thu, 11 Apr 2002 20:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313083AbSDLAJw>; Thu, 11 Apr 2002 20:09:52 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:21262 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S313082AbSDLAJv>; Thu, 11 Apr 2002 20:09:51 -0400
Message-ID: <3CB61AC7.5AB77189@opersys.com>
Date: Thu, 11 Apr 2002 19:22:47 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Torrey Hoffman <thoffman@arnor.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: measuring time spent in kernel
In-Reply-To: <1018569297.15331.4.camel@shire.arnor.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You may want to try LTT:
http://www.opersys.com/LTT

It will give this sort of information, among many other things,
and it doesn't soak up any cycles.

Karim

Torrey Hoffman wrote:
> 
> "top" and similar tools don't seem to capture the time spent in kernel
> which isn't on behalf of a user process.
> 
> I vaguely remember mention on this list of a tool that soaks up as many
> cycles as it can get to obtain an accurate measurement of the true
> system time.
> 
> Can some one give me a pointer?  I've had no luck with Google...
> 
> thanks,
> 
> Torrey Hoffman
> thoffman@arnor.net
> torrey.hoffman@myrio.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
