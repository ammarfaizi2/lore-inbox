Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbRD2OOP>; Sun, 29 Apr 2001 10:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRD2OOG>; Sun, 29 Apr 2001 10:14:06 -0400
Received: from viper.haque.net ([66.88.179.82]:52610 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135380AbRD2ONx>;
	Sun, 29 Apr 2001 10:13:53 -0400
Message-ID: <3AEC219C.3B4618AB@haque.net>
Date: Sun, 29 Apr 2001 10:13:48 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Konerding <dek_ml@konerding.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: traceroute breaks with 2.4.4
In-Reply-To: <3AEBE142.E3CAD85E@konerding.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Konerding wrote:
> As far as I can tell, somewhere between 2.4.2 and 2.4.4, traceroute
> stopped working.
> I see the problem on RH7.x.  Regular kernel compile with near-defaults
> for networking,
> no firewalling is enabled.  Rebootiing to a similar config under 2.4.2
> works OK.

Traceroute is working fine here. You sure you didn't inadvertantly turn
on ECN w/o knowing it?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
