Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRHCJK0>; Fri, 3 Aug 2001 05:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269373AbRHCJKQ>; Fri, 3 Aug 2001 05:10:16 -0400
Received: from weta.f00f.org ([203.167.249.89]:54415 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269372AbRHCJJ7>;
	Fri, 3 Aug 2001 05:09:59 -0400
Date: Fri, 3 Aug 2001 21:10:46 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: john slee <indigoid@higherplane.net>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: booting SMP P6 kernel on P4 hangs.
Message-ID: <20010803211046.A16299@weta.f00f.org>
In-Reply-To: <20010803000043.F1183@higherplane.net> <E15SJnZ-0000lB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15SJnZ-0000lB-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 03:50:05PM +0100, Alan Cox wrote:

    Which gives intel plenty of time to fix their bios problems. Right
    now the situation is we are seeing Pentium IV boxes reporting
    invalid MP 1.4 specs and dying. Reporting an invalid MP spec and
    booting single user at least ensures people can boot their boxes
    while intel fixes their problems

I assume these things, even with busted MP tables will work under
Win2k as it will use ACPI tables instead (I'm assuming they are
available abd valid?).

What about NT4?  If that can also use ACPI tables (I can't see how, it
predates ACPI I think) then it may well be Linux is the only thing
that stil uses MP tables and hence won't boot in such machines :(



  --cw
