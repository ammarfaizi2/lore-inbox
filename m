Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRHaRG6>; Fri, 31 Aug 2001 13:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbRHaRGs>; Fri, 31 Aug 2001 13:06:48 -0400
Received: from [195.89.159.99] ([195.89.159.99]:11773 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S268342AbRHaRGb>; Fri, 31 Aug 2001 13:06:31 -0400
Date: Fri, 31 Aug 2001 18:07:07 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Keith Owens <kaos@ocs.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac5
Message-ID: <20010831180707.B25490@thefinal.cern.ch>
In-Reply-To: <9293.999222514@kao2.melbourne.sgi.com> <200108310543.f7V5h3S452102@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108310543.f7V5h3S452102@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Fri, Aug 31, 2001 at 01:43:03AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> The LGPL, X11, and 2-clause BSD licenses shouldn't set the tainted flag.
> Perhaps the licenses should simply be listed.
> 
> $ cat /proc/sys/kernel/licenses
> GPL
> Public Domain
> unknown
> BSD(2)
> Microsoft-EULA-v666

Print the loaded modules, and their licenses, one per line?
"Microsoft-EULA-v666" is a bit confusing if you don't know where it came
from.

Also, I see "GPL".  With Linus' and Alan's declarations last year,
shouldn't it be:

  GPL version 2 only
  GPL version 2 (or, at your option, any later version)

;-) no that's not a serious suggestion.

-- Jamie


