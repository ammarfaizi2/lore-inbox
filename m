Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281175AbRKOXcB>; Thu, 15 Nov 2001 18:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRKOXbv>; Thu, 15 Nov 2001 18:31:51 -0500
Received: from jalon.able.es ([212.97.163.2]:65523 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281175AbRKOXbf>;
	Thu, 15 Nov 2001 18:31:35 -0500
Date: Fri, 16 Nov 2001 00:31:26 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Michael Peddemors <michael@wizard.ca>
Cc: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: loop back broken in 2.2.14
Message-ID: <20011116003126.C1735@werewolf.able.es>
In-Reply-To: <Springmail.105.1005761843.0.30236800@www.springmail.com> <1005860255.9913.794.camel@mistress>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1005860255.9913.794.camel@mistress>; from michael@wizard.ca on Thu, Nov 15, 2001 at 22:37:35 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011115 Michael Peddemors wrote:
>Yes, I seriously considered the feasibility of having 2.4.14-fixed
>kernels around, but I could just imagine trying to deal with millions of
>people trying to download known good kernels on our bandwidth...
>
>It would be good to be able to point people to a stable kernel.. instead
>of having to recommend kernels in the pre-series..
>
...
>On Wed, 2001-11-14 at 10:17, joeja@mindspring.com wrote:
>> I think that was suggested a while ago, in the 2.2 days.  It didn't fly! There was however a general consensus that for small bugs that are found in a 'stable' release there should be fixes for just the bug as the next release.  I.E. 2.2.15 should be released with just the one fix.  Linus didn't seem to go for that as well as some other developers .
>> 

Well, Linus could post a 'errata' patch...
Layout now in ftp space is (reverse date order):

	test-kernels
	ChangeLog-2.4.14
	LATEST-IS-2.4.14
	linux-2.4.14.tar.bz2

A couple files could be posted, named Errata-2.4.14 and linux-2.4.14-errata.bz2,
first being a description of what the second (the patchs) cures...with names like
that so the listing gets them visible near the main tarball...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre4-beo-2 #1 SMP Thu Nov 15 13:02:43 CET 2001 i686
