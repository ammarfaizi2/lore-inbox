Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbRCJTAP>; Sat, 10 Mar 2001 14:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131121AbRCJTAF>; Sat, 10 Mar 2001 14:00:05 -0500
Received: from viper.haque.net ([64.0.249.226]:3723 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S131119AbRCJS7y>;
	Sat, 10 Mar 2001 13:59:54 -0500
Message-ID: <3AAA7979.1F923CC6@haque.net>
Date: Sat, 10 Mar 2001 13:59:05 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen M. Williams" <rootusr@midsouth.rr.com>
CC: Miquel van Smoorenburg <miquels@cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.1 on RHL 6.2
In-Reply-To: <001401c0a970$ec3c9b00$1d9509ca@pentiumiii>
		<200103101754.f2AHsUL04580@mailout1-100bt.midsouth.rr.com> 
		<98drnp$qq0$1@ncc1701.cistron.net> <200103101845.f2AIjuL10614@mailout1-100bt.midsouth.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen M. Williams" wrote:
> 
> Wow, I had no idea.  I was following advice I received a long time ago
> from a mailing list.  If I remove those symlinks how do I go about
> compiling the kernel without receiving the same errors as Srinath?

Note that he said distributions such as RedHat (pre 7.0 .. I think 7.0
does it correctly). On other distros those headers are/should be
included with the glibc devel stuff.

You could probably copy those dirs into place on the broken distros
without problems.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
