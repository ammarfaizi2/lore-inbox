Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSFCJOY>; Mon, 3 Jun 2002 05:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSFCJOX>; Mon, 3 Jun 2002 05:14:23 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:59147 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S317326AbSFCJOW>; Mon, 3 Jun 2002 05:14:22 -0400
Message-ID: <3CFB3378.5EB7420@opersys.com>
Date: Mon, 03 Jun 2002 05:14:32 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Philippe Gerum <rpm@idealx.com>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <3CFB2A38.60242CBA@opersys.com> <20020603084606.GA15986@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik Andersen wrote:
> Looks kindof cool in theory.  Have you done any benchmarking on
> the performance hit on Linux kernel vs baseline?

Philippe has done some preliminary testing with dbench/tbench and
he got something like < 1%. Of course, more testing is required.

>  What is the
> software patent outlook for this approach look like?

Alessandro's answer is to the point. Basically, grab the papers,
the code and the patent and have a look for yourself, you will see
that we're clear. Apart from having the kernels side-by-side,
Adeos is based on classic early '90s nanokernel work. No secrets
there.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
