Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288460AbSANAoA>; Sun, 13 Jan 2002 19:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288494AbSANAmo>; Sun, 13 Jan 2002 19:42:44 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:46854 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288460AbSANAls>; Sun, 13 Jan 2002 19:41:48 -0500
Message-ID: <3C42293F.4962EC82@linux-m68k.org>
Date: Mon, 14 Jan 2002 01:41:35 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
        Kenneth Johansson <ken@canit.se>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16Pmok-0007GD-00@the-village.bc.nu> <3C41ED4E.4D3F2D2C@linux-m68k.org> <20020113171006.A17958@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> > It's a useful patch for anyone, who needs good latencies now, but it's
> > still a quick&dirty solution. Preempt offers a clean solution for a
> > certain part of the problem, as it's possible to cleanly localize the
> > needed changes for preemption (at least for UP). That means the ll patch
> > becomes smaller and future work on ll becomes simpler, since a certain
> 
> That is exactly what Andrew Morton disputes. So why do you think he is
> wrong?

Please explain, what do you mean?

bye, Roman
