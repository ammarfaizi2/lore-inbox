Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263187AbREWRwo>; Wed, 23 May 2001 13:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbREWRwe>; Wed, 23 May 2001 13:52:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57838 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S263187AbREWRwU>; Wed, 23 May 2001 13:52:20 -0400
Message-ID: <3B0BF8B6.D7940FA3@mvista.com>
Date: Wed, 23 May 2001 17:51:50 +0000
From: Scott Anderson <scott_anderson@mvista.com>
Organization: MontaVista Software Inc.
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Pavel Machek <pavel@suse.cz>, Rik van Riel <riel@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105200957500.323-100000@mikeg.weiden.de> <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva> <20010520235409.G2647@bug.ucw.cz> <20010521223212.C4934@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> IMVHO every developer involved in memory-management (and indeed, any
> software development; the authors of ntpd comes in mind here) should
> have a 386 with 4MB of RAM and some 16MB of swap. Nowadays I have the
> luxury of a 486 with 8MB of RAM and 32MB of swap as a firewall, but it's
> still a pain to work with.

If you really want to have fun, remove all swap...

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085
