Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261155AbRERQqI>; Fri, 18 May 2001 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261158AbRERQp6>; Fri, 18 May 2001 12:45:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:26108 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S261155AbRERQps>; Fri, 18 May 2001 12:45:48 -0400
Message-ID: <3B0551B4.CB251F64@redhat.com>
Date: Fri, 18 May 2001 17:45:40 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <20010518115839.E14309@thyrsus.com> <E150mhR-0007Ig-00@the-village.bc.nu> <20010518123413.I14309@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> > It would. Because people who like the old config would continue to use the
> > old tools
> 
> Excuse me?

> Do you really believe that anyone is going to maintain the CML1 tools
> for as long as a nanosecond after they get dropped out of the kernel tree?

I hereby volunteer to maintain at least make oldconfig and make config, 
and perhaps make menuconfig.

 
> Even supposing somebody were loony enough to do that, how would preserving
> an old interface in amber do anything to explore new UI possibilities?

kernel != GUI

There are plenty of UI kernel configurators out there. Good ones. Bad
ones. 
LOOK AT THEM. FIX THEM if you don't like them. But PLEASE don't even
think
about taking the current, very useful for advanced users, tools away
without
offering something of at least the same capabilities.

 
> Perhaps I'm just unusually dense this morning.

Given the rest of this thread, unusual is not the word that comes to my
mind
(sorry, open door and you asked for it)
