Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317361AbSFCKiQ>; Mon, 3 Jun 2002 06:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSFCKiP>; Mon, 3 Jun 2002 06:38:15 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:31239 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S317361AbSFCKiN>; Mon, 3 Jun 2002 06:38:13 -0400
Message-ID: <3CFB472A.9BE948FF@opersys.com>
Date: Mon, 03 Jun 2002 06:38:34 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Philippe Gerum <rpm@idealx.com>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <3CFB2A38.60242CBA@opersys.com> <20020603084606.GA15986@codepoet.org> <3CFB3378.5EB7420@opersys.com> <20020603095202.GA16392@codepoet.org> <3CFB40FB.E997F3E6@opersys.com> <20020603103328.GA16985@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik Andersen wrote:
> On Mon Jun 03, 2002 at 06:12:11AM -0400, Karim Yaghmour wrote:
> > The problem here is the "quick glance" (no offense intended). The
> > most important part of a patent is its claims. In the case of the
> 
> no offense taken.  I'm not a lawyer, so much beyond a quick
> glance teaches me very little when reading such things.

Just one thing. Patents are not just for lawyers. In fact, patents are
supposed to explain to anyone vested in the art how to implement the
"invention"
. In this case, this means that anyone who has a knowledge
of operating system architecture should be able to read this patent and
understand it for what it is.

> > any such RTOS need not even know Linux is there. All it needs to
> > know is that it has to call on adeos_suspend_domain() to go into
> > a dormant state when it doesn't have any more "ready" tasks. In
> > no way does it have a "Linux" task, as RTLinux and RTAI clearly
> > do.
> 
> Thanks much for the explanation -- that was exactly what I
> was hoping to see.  Very very cool.

Thanks, glad you like it :)

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
