Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283926AbRLAFCd>; Sat, 1 Dec 2001 00:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283931AbRLAFCO>; Sat, 1 Dec 2001 00:02:14 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13820
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283926AbRLAFCC>; Sat, 1 Dec 2001 00:02:02 -0500
Date: Fri, 30 Nov 2001 21:01:55 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Larry McVoy <lm@bitmover.com>, akpm@zip.com.au, phillips@bonn-fries.net,
        hps@intermeta.de, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011130210155.B489@mikef-linux.matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Larry McVoy <lm@bitmover.com>, akpm@zip.com.au,
	phillips@bonn-fries.net, hps@intermeta.de, jgarzik@mandrakesoft.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <E169scn-0000kt-00@starship.berlin> <20011130110546.V14710@work.bitmover.com> <E169vcF-0000lQ-00@starship.berlin> <E169vcF-0000lQ-00@starship.berlin> <20011130155740.I14710@work.bitmover.com> <20011201022157.38ed90b5.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201022157.38ed90b5.skraw@ithnet.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 02:21:57AM +0100, Stephan von Krawczynski wrote:
> _the_ last guy talking about it at all. So lets simply assume this: the Solaris
> UP market is already gone, if you are talking about the _mass_ market. This
> parrot is _deceased_! It is plain dead.

Not completely.  Many people who *need* to develop for solaris on sun
hardware will run solaris x86 at home (or maybe on a corporate laptop) to be
able to work at home and test the software there too.  I know one such
developer myself, there have to be more.

> So maybe
> the real good choice would be this: let the good parts of Solaris (and maybe
> its SMP features) migrate into linux. 

Before 2.3 and 2.4 there probably would've been much more contention against
something like this.  Even now with large SMP scalability goals, I think it
would be hard to get something like this to be accepted into Linux.

mf
