Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSHPBoZ>; Thu, 15 Aug 2002 21:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHPBoZ>; Thu, 15 Aug 2002 21:44:25 -0400
Received: from relay1.pair.com ([209.68.1.20]:49682 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317874AbSHPBoZ>;
	Thu, 15 Aug 2002 21:44:25 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D5C5B0E.9EEA37EB@kegel.com>
Date: Thu, 15 Aug 2002 18:53:18 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: 
 async-io API registration for 2.5.29)]
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> See the SuS API:
> 
>         http://www.opengroup.org/onlinepubs/007908799/xsh/aio.h.html

There's a new release of the SuS, see

http://www.opengroup.org/onlinepubs/007904975/basedefs/aio.h.html

Harder to miss lio_listio() with the new one.
- Dan
