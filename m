Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318092AbSGWPCn>; Tue, 23 Jul 2002 11:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318093AbSGWPCn>; Tue, 23 Jul 2002 11:02:43 -0400
Received: from handhelds.org ([192.58.209.91]:11735 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S318092AbSGWPCl>;
	Tue, 23 Jul 2002 11:02:41 -0400
From: George France <france@handhelds.org>
To: "Martin Brulisauer" <martin@uceb.org>,
       "Oliver Pitzeier" <o.pitzeier@uptime.at>
Subject: Re: kbuild 2.5.26 - arch/alpha
Date: Tue, 23 Jul 2002 11:05:51 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
References: <200207211354.g6LDsADU005586@alder.intra.bruli.net> <3D3D6B3B.25754.1392D3FD@localhost>
In-Reply-To: <3D3D6B3B.25754.1392D3FD@localhost>
MIME-Version: 1.0
Message-Id: <02072311055101.22920@shadowfax.middleearth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 July 2002 08:42, Martin Brulisauer wrote:
> On 21 Jul 2002, at 18:57, Oliver Pitzeier wrote:
> > I'm also currently not sure that kernel 2.6.X will
> > ever run on alpha. There are not very much alpha-users.
> > And there are lesser alpha kernel maintainers.
> > Ivan Kokshaysky and "Thunder from the hill" are two
> > persons who often work an the Alpha Code. And me
> > as well (a bit....). But it's currently not easy
> > to fix the new errors (for alpha) in every kernel
> > release, because they are growing...

2.6.x will run on alpha.  There are still a handfull of people that still 
activly maintian Linux on Alpha.   Since there is only a few people that 
activly work on Alpha, they tend to chose a kernel versions, then work with 
that version for a while until it is stable.  In the past few months most of 
the efforts have been spent on 2.4.9.  Currently there have been discussions 
in regard to:

1) porting all those patches for 2.4.9 forward to 2.4.[18-19] and 2.5.x.  
2) taking a look at the latest 2.5.x in the next few weeks, as we are aware 
that 2.5.x does not compile on Alpha.

>
> Do you think it's worth the time to patch the current
> version? Will Linus apply the patch so we will hopefully
> have a 2.6.x kernel that compiles (at least) on alpha's?

It is certainly worth the time.  It is not too difficult to get any sane 
patch applied to the kernel for Alpha.  

>
> Is there anybody who is willing to test such a patch
> on different alpha's (I only have some XLT's, an AS800
> and one AS250, so all alcor based systems with
> ISA and PCI but without EISA and all are using sys_alcor.c)?
> Further I can't test SMP with this _very_ old hardware.

I have access to a Lab that is filled with Alpha systems.  I would be happy 
to test any patch as I have time.

Please let me know if I can be of further assistence.

Best Regards,


--George.
