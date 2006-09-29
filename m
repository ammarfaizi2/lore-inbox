Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWI2Oyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWI2Oyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 10:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWI2Oyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 10:54:38 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43944 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750749AbWI2Oyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 10:54:37 -0400
Message-Id: <200609291454.k8TEsVJZ022006@laptop13.inf.utfsm.cl>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Neil Brown <neilb@suse.de>, tridge@samba.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement 
In-Reply-To: Message from James Bottomley <James.Bottomley@SteelEye.com> 
   of "Thu, 28 Sep 2006 23:56:37 MST." <1159512998.3880.50.camel@mulgrave.il.steeleye.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Fri, 29 Sep 2006 10:54:31 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Recipient e-mail whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 29 Sep 2006 10:54:34 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[IANAL, just an interested bystander]

James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Fri, 2006-09-29 at 14:40 +1000, Neil Brown wrote:
> > You seem to be saying that including software in a product that you
> > then distribute is *both* a USE and a DISTRIBUTION of that software.

Use is irrelevant; under US copyright law you can do whatever you want with
what you got legally. The "use" clauses aren't any special dispensation by
the GPL.

> Sort of ... I'm asserting that producing something (an appliance say, or
> a PCI card) that runs linux to achieve its function is a "use" (an act
> of running the program) within the meaning of GPLv2 clause 0.

Not necessarily, but it doesn't matter anyway.

>                                                                Selling
> the Box (or card, or whatever) also becomes a distribution.

Sure does.

> > So if the software is obtained under the GPL, and the GPL asserts "no
> > restrictions on use" then it should also not restrict distribution.

It doesn't, AFAICS.

> > It can place requirements that must be met before distribution is
> > allowed, but they shouldn't be so onerous as to inhibit distribution.
> > Does that sound right?

> Not exactly.  Under v2, there are specific duties that go along with the
> act of distributing (providing access to the source code and all
> modifications),

No. Just to the full source code. It is very nice from distribution
builders that e.g. an SRPM includes the original code plus patches, and of
Linus that you can rumage around in Linux' git repository to trace the
history, but that isn't a requirement of GPLv2 at all.

>                 but explicitly none on end use.  You can't get out of
> the distribution requirements simply by claiming it's also a use.

Right.

> However I claim that, the GPLv3 requirement that you be able to "execute
> modified versions from source code in the recommended or principal
> context of use" does constitute an end use restriction on the embedded
> system because the appliance (or card, or whatever) must be designed in
> such a way as to allow this.

It tries to leverage the license on the software to force certain hardware
(or use) designs. Problem is, it won't work. Can't use FunkyOS for DRMing
because it is GPLv3? Just use AnotherOS then. Or FunkyOS will do, and run
propietary software on top of it that does all the nasty stuff anyway. This
isn't rocket science, machines are so powerful today that developing such
custom software isn't a tour de force anymore, and there are several
alternatives out there, ones free for the taking and paid ones.

Folks, open source is /very, very far/ from being prevalent enough to force
anti-<whatever> provisions through via its software license (if that made
any sense, which I very much doubt); and if it was, doing so would probably
be moot anyway.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
