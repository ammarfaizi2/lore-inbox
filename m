Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265734AbSJYAUl>; Thu, 24 Oct 2002 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSJYAUl>; Thu, 24 Oct 2002 20:20:41 -0400
Received: from mail.ccur.com ([208.248.32.212]:54793 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S265734AbSJYATZ>;
	Thu, 24 Oct 2002 20:19:25 -0400
Message-ID: <3DB88F6D.F408FF06@ccur.com>
Date: Thu, 24 Oct 2002 20:25:17 -0400
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: landley@trommello.org, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

The Posix timers entry in your list is confused.  I don't know how
my patch got the name Google.

I think Dan Kegel misunderstood George's answer to my previous announcement.  George might be picking up some of my changes, but
there will still be two
patches for Linus to choose from.  You included the URL to George's answer
which quoted my patch, rather than the URL I sent you.

Here is the URL for an archived copy of my latest patch:
     Jim Houston's  [PATCH] alternate Posix timer patch3
     http://marc.theaimsgroup.com/?l=linux-kernel&m=103549000027416&w=2

I would be happy to see either version go into 2.5.  

The URLs for George's patches are incomplete.  I believe this is the
most recent (it's from Oct 18).  The Sourceforge.net reference has the
user space library and test programs, but I did not see 2.5 kernel
patches.

  [PATCH ] POSIX clocks & timers take 3 (NOT HIGH RES)
     http://marc.theaimsgroup.com/?l=linux-kernel&m=103489669622397&w=2

Thanks
Jim Houston - Concurrent Computer Corp.
