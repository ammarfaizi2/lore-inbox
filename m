Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWD0Ou6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWD0Ou6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWD0Ou6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:50:58 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:25874 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S965131AbWD0Ou6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:50:58 -0400
Date: Thu, 27 Apr 2006 16:50:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <20060427145054.GA19502@mars.ravnborg.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org> <6B929F57-12EB-4E91-A191-2F0DABB77962@mac.com> <445026EB.8010407@yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 11:37:05PM -0400, Kyle Moffett wrote:
> >
> >I agree, it would be a bad idea to compile the existing C code by g+ 
> >+.  The good idea is to be able to produce new C++ modules etc.
> 
> No, this is a reason why C++ modules are _not_ a good idea.  If you  
> could write the module in C or C++, but in C++ it compiled 100-200%  
> slower, then you would write it in C.
The original issue was the possibility to add support for C++
solely to support an existing implementation of a filesystem.
Not to rewrite the kernel in C++, neither to encourage the use of C++.
And with this in mind the figures above does not matter.

Likewise does neiter of the many arguments in this thread.
Now if the C++ fans could present what is needed to actually support
building a module in C++ instead of arguing.....

	Sam
