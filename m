Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277722AbRJROLb>; Thu, 18 Oct 2001 10:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277721AbRJROLW>; Thu, 18 Oct 2001 10:11:22 -0400
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:26862 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S277722AbRJROLJ>; Thu, 18 Oct 2001 10:11:09 -0400
Date: Thu, 18 Oct 2001 10:11:34 -0400
From: Ben Collins <bcollins@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Non-GPL modules
Message-ID: <20011018101134.Q10952@visi.net>
In-Reply-To: <Pine.NEB.4.40.0110181529400.1110-100000@mimas.fachschaften.tu-muenchen.de> <Pine.LNX.3.95.1011018094613.431A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1011018094613.431A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 09:58:33AM -0400, Richard B. Johnson wrote:
> On Thu, 18 Oct 2001, Adrian Bunk wrote:
> 
> > On Thu, 18 Oct 2001, Richard B. Johnson wrote:
> > 
> > >...
> > > In the business world, something as simple as puts("Hello World!");
> > > MUST be kept a trade secret. If it was written by an employee
> > > in the context of his or her job, the company's stockholders owns
> > > that line of code so no employee, even the President, is allowed
> > > to give it away.
> > >...
> > 
> > IOW: Companies like IBM, SAP, Sun and SGI that made code available under
> > the GPL (e.g. as part of the linux kernel or with of relicensed programs)
> > weren't allowed to do this???
> > 
> > 
> > Am I allowed to consider this a bad joke?
> > 
> > 
> 
> It's no joke. Some companies require, in the process of producing
> goods and services, that certain interface code and documentation
> be provided. For instance, if I make an Ethernet card, it's in
> the best interest of the company to sell as many boards as possible.
> Therefore, certain information must be given away to obtain those
> goals. So, I would provide register-level documentation, sample
> source-code, and maybe even drivers for the majority of the known
> Operating Systems.
> 
> However, If my company makes Bomb Scanners (it does), I cannot
> divulge to potential adversaries, either the competition or potential
> bombers, how it works. It's just that simple.
> 
> If your end product is a board that plugs into a PC, you have a
> different set of rules than if your end product is a Bomb Scanner,
> a Flight Management System, or a Numerical Milling Machine.
> Basically, embedded stuff, both hardware and software, remains hidden.

But that has nothing to do with stockholders claiming ownership of code
written by an employee. That's a much deeper policy. So your assertions
are way off base.

Now, if your driver just interfaces your hardware with userspace, then
that driver likely contains nothing of extreme importance for how your
"Bomb Scanner" works, and releasing it under GPL is not going to be a
problem. Your application contains those details. I don't see how you
are getting at the application level being considered a corrupter of the
kernel's GPL stringency. Do you actually see this occuring?

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
