Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262921AbRE1CzV>; Sun, 27 May 2001 22:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbRE1CzL>; Sun, 27 May 2001 22:55:11 -0400
Received: from chromium11.wia.com ([207.66.214.139]:48652 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S262921AbRE1CzA>; Sun, 27 May 2001 22:55:00 -0400
Message-ID: <3B11BF00.398100E3@chromium.com>
Date: Sun, 27 May 2001 19:59:12 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com,
        Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@redhat.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Zach Brown <zab@zabbo.net>
Subject: License Clarification [X15 beta 1 - source release]
In-Reply-To: <3B0F018B.A9823BD4@chromium.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people pointed out that I misused the term "Open Source" wrt our Source
License.

Our license doesn't meet the required criteria of the OSI since we restrict
the usage of our sources for personal use only. As was already pointed out in
my previous message people will have to buy a license for commercial
exploitation of the code (i.e. running a commercial web site).

Sorry for the inconvenience,

 - Fabio

Fabio Riccardi wrote:

> Dear all,
>
> I finally managed to package the X15 web accelerator for the first
> source release.
>
> The current release includes a CGI module, an Apache configuration
> module and several salability improvements. It is a beta 1, quite stable
> but it may/will still contain a few bugs. The README is a bit outdated
> and the code could use more comments... :)
>
> The code It is released under an Open Source license very much in the
> spirit of Sun/Solaris, Apple/Darwin, etc., but less restrictive.
>
> Basically (for what I have been explained by our lawyers :) the license
> says that:
>
>  1) you can peruse the code for your own use and/or research in any way
> you like,
>
>  2) you can use X15 for your own non commercial use (i.e., you can have
> the fastest family reunion pictures website of the planet),
>
>  3) if you want to use the software for any commercial exploitation you
> have to buy a license from Chromium Communications,
>
>  4) if you make changes they belong to you, but if you send them back to
> us than you agree to not claim anything for them.
>
> You can get the sources from:
> http://www.chromium.com/cgi-bin/crosforum/YaBB.pl
>
> or (when the DNS gets propagated) from: http://source.chromium.com/
>
> Our source site sports one of those nifty sourceforge-like interfaces
> for discussions, bug reports and whatever, I'd prefer you to use that
> instead of sending email directly to me or to this list.
>
> I'll build a proper "product" web page and add more documentation in the
> next few days.
>
>  - Fabio
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

