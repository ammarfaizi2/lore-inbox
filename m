Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbREZBCZ>; Fri, 25 May 2001 21:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbREZBCP>; Fri, 25 May 2001 21:02:15 -0400
Received: from chromium11.wia.com ([207.66.214.139]:13831 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S262355AbREZBCE>; Fri, 25 May 2001 21:02:04 -0400
Message-ID: <3B0F018B.A9823BD4@chromium.com>
Date: Fri, 25 May 2001 18:06:19 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Smith <x@xman.org>,
        Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com,
        Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@redhat.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Zach Brown <zab@zabbo.net>
Subject: X15 beta 1 - source release
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I finally managed to package the X15 web accelerator for the first
source release.

The current release includes a CGI module, an Apache configuration
module and several salability improvements. It is a beta 1, quite stable
but it may/will still contain a few bugs. The README is a bit outdated
and the code could use more comments... :)

The code It is released under an Open Source license very much in the
spirit of Sun/Solaris, Apple/Darwin, etc., but less restrictive.

Basically (for what I have been explained by our lawyers :) the license
says that:

 1) you can peruse the code for your own use and/or research in any way
you like,

 2) you can use X15 for your own non commercial use (i.e., you can have
the fastest family reunion pictures website of the planet),

 3) if you want to use the software for any commercial exploitation you
have to buy a license from Chromium Communications,

 4) if you make changes they belong to you, but if you send them back to
us than you agree to not claim anything for them.

You can get the sources from:
http://www.chromium.com/cgi-bin/crosforum/YaBB.pl

or (when the DNS gets propagated) from: http://source.chromium.com/

Our source site sports one of those nifty sourceforge-like interfaces
for discussions, bug reports and whatever, I'd prefer you to use that
instead of sending email directly to me or to this list.

I'll build a proper "product" web page and add more documentation in the
next few days.

 - Fabio


