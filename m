Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288384AbSANANG>; Sun, 13 Jan 2002 19:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288393AbSANAM5>; Sun, 13 Jan 2002 19:12:57 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:35601 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288384AbSANAMu>;
	Sun, 13 Jan 2002 19:12:50 -0500
Date: Sun, 13 Jan 2002 17:10:06 -0700
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
        Kenneth Johansson <ken@canit.se>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113171006.A17958@hq.fsmlabs.com>
In-Reply-To: <E16Pmok-0007GD-00@the-village.bc.nu> <3C41ED4E.4D3F2D2C@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C41ED4E.4D3F2D2C@linux-m68k.org>; from zippel@linux-m68k.org on Sun, Jan 13, 2002 at 09:25:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 09:25:50PM +0100, Roman Zippel wrote:
> I don't doubt that, but would you seriously consider the ll patch for
> inclusion into the main kernel?
> It's a useful patch for anyone, who needs good latencies now, but it's
> still a quick&dirty solution. Preempt offers a clean solution for a
> certain part of the problem, as it's possible to cleanly localize the
> needed changes for preemption (at least for UP). That means the ll patch
> becomes smaller and future work on ll becomes simpler, since a certain

That is exactly what Andrew Morton disputes. So why do you think he is
wrong?


