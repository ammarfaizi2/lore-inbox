Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423456AbWBBKtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423456AbWBBKtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423457AbWBBKtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:49:51 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:41705 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1423456AbWBBKtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:49:50 -0500
Message-ID: <43E1E2F2.1090102@andrew.cmu.edu>
Date: Thu, 02 Feb 2006 05:46:10 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?RW1pbGlvIEplc8O6cyBHYWxsZWdvIEFyaWFz?= 
	<egallego@babel.ls.fi.upm.es>
CC: Linus Torvalds <torvalds@osdl.org>, Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> <43DE57C4.5010707@opersys.com> <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com> <200601302301.04582.brcha@users.sourceforge.net> <43E0E282.1000908@opersys.com> <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org> <43E1C55A.7090801@drzeus.cx> <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org> <87mzha85sc.fsf@babel.ls.fi.upm.es>
In-Reply-To: <87mzha85sc.fsf@babel.ls.fi.upm.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emilio Jesús Gallego Arias wrote:
>... 
> 1.- Distribute a kernel with some DRM built-in under the GPL.
> 
> 2.- Claim that such kernel is an effective technological measure to
>     protect copyright. 

You forgot:

2.5- Due to the DMCA, the code now has an additional restriction on
      top of what is already in its license, the GPL v2.  The GPL v2
      forbids additional restrictions, and thus the resulting work
      cannot be distributed.

> 3.- You are no longer free to modify that kernel, (removing the DRM
>     module) or you can be sued under the DMCA, for circumventing an
>     effective technological measure. It doesn't matter in what
>     hardware are you going to run such kernel. The DMCA implicitly
>     imposes an additional restriction to the GPL, but as the
>     restriction is not imposed directly by the copyright owner, but by
>     the law, it's OK as far the GPL is concerned.

If the DRM author(s) are the ones claiming the DRM is an "effective 
technological measure", then they are the ones imposing an additional 
restriction.  Those authors are the ones who can be sued, not the end 
users of the kernel+DRM.  If someone else makes the claim, it carries no 
weight at all, because they are not the author or copyright owner.

Also, remember that the GPL is about DISTRIBUTION only.  You are always 
free to modify whatever you want.  So your #3 is just plain wrong, as 
you still can modify the kernel.  What you can't do is distribute that 
modified version, although that's a meaningless since #2.5 shows you 
couldn't distribute the unmodified version anyway.

The modification vs. distribution point cannot be emphasized enough, as 
far too many people miss this important distinction when thinking about 
the GPL.  Nothing in GPL software becomes magically illegal at any 
point; The only thing that can be legal or not is distribution.  I am 
free to mix Linux, Open Solaris, GCC, and BSD code with the advertising 
clause, and top it off with GNU FDL docs, and do so to my hearts' 
content.  The only thing I *can't* do with that abomination is 
distribute it.

  - Jim Bruce
