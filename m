Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277827AbRJRRJc>; Thu, 18 Oct 2001 13:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277808AbRJRRJX>; Thu, 18 Oct 2001 13:09:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47374 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S277827AbRJRRJD>; Thu, 18 Oct 2001 13:09:03 -0400
Message-ID: <3BCF0B10.CFA9E3FB@evision-ventures.com>
Date: Thu, 18 Oct 2001 19:02:08 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Ben Collins <bcollins@debian.org>, Adrian Bunk <bunk@fs.tum.de>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Non-GPL modules
In-Reply-To: <Pine.LNX.3.95.1011018101831.603A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 18 Oct 2001, Ben Collins wrote:
> 
> > On Thu, Oct 18, 2001 at 09:58:33AM -0400, Richard B. Johnson wrote:
> > > On Thu, 18 Oct 2001, Adrian Bunk wrote:
> > >
> > > > On Thu, 18 Oct 2001, Richard B. Johnson wrote:
> > > >
> > > > >...
> > > > > In the business world, something as simple as puts("Hello World!");
> > > > > MUST be kept a trade secret. If it was written by an employee
> > > > > in the context of his or her job, the company's stockholders owns
> > > > > that line of code so no employee, even the President, is allowed
> > > > > to give it away.
> > > > >...
> > > >
> > > > IOW: Companies like IBM, SAP, Sun and SGI that made code available under
> > > > the GPL (e.g. as part of the linux kernel or with of relicensed programs)
> > > > weren't allowed to do this???
> > > >
> > > >
> > > > Am I allowed to consider this a bad joke?
> > > >
> > > >
> > >
> > > It's no joke. Some companies require, in the process of producing
> > > goods and services, that certain interface code and documentation
> > > be provided. For instance, if I make an Ethernet card, it's in
> > > the best interest of the company to sell as many boards as possible.
> > > Therefore, certain information must be given away to obtain those
> > > goals. So, I would provide register-level documentation, sample
> > > source-code, and maybe even drivers for the majority of the known
> > > Operating Systems.
> > >
> > > However, If my company makes Bomb Scanners (it does), I cannot
> > > divulge to potential adversaries, either the competition or potential
> > > bombers, how it works. It's just that simple.
> > >
> > > If your end product is a board that plugs into a PC, you have a
> > > different set of rules than if your end product is a Bomb Scanner,
> > > a Flight Management System, or a Numerical Milling Machine.
> > > Basically, embedded stuff, both hardware and software, remains hidden.
> >
> > But that has nothing to do with stockholders claiming ownership of code
> > written by an employee. That's a much deeper policy. So your assertions
> > are way off base.
> >
> 
> The assertions are right on. Not off base. The amount of "ownership"
> exercised by the public in a publicly-held company depends upon the
> capitalization, share dilution, and amount of outstanding shares. As the
> ownership (stockholder votes) increases, the company policy becomes
> becomes more of maximizing return on investment, and less of producing
> good or services. This is Business 101. As stockholder equity increases,
> eventually everything an employee produces becomes more-and-more owned
> by the public investors, and less-and-less owned by some company
> "division" or "department". In effect, the "company" exists only for
> the convenience of its share-holders. General Electric is an example.
> 
> > Now, if your driver just interfaces your hardware with userspace, then
> > that driver likely contains nothing of extreme importance for how your
> > "Bomb Scanner" works, and releasing it under GPL is not going to be a
> > problem. Your application contains those details. I don't see how you
> > are getting at the application level being considered a corrupter of the
> > kernel's GPL stringency. Do you actually see this occuring?
> >
> 
> We have a data interface that feeds high-speed data from 4,000 +
> X-Ray detectors directly to memory at RAM/Bus memory speeds. There
> is no way in hell that we are going to let the world know how this
> is done. We can't protect it by patent because there is a lot of
> "prior art" which has been confused by a Patent Examiner as something
> in the past that actually worked.
> 
> Review of the driver source-code by a competent hardware designer,
> who knows how to read code, will give away the trade secret. Then
> anybody, who hasn't bothered to invest the millions of dollars of
> Engineering development cost, can make one of these cheaper and
> put us out of business.

And what about the simple fact that the tainted flag will become
entierly useless when in fact most of us will be using tainted
kernel? Hey anyway most of us are now deploying "tainted" linux
distributions anyway and NOT GNU/Linux Debian. Most of use use
distros and kernels far away from the official Linus kernel too, so
this flagging doesn't help anybody it's just BLOAT.
