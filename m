Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRHDEPo>; Sat, 4 Aug 2001 00:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269791AbRHDEPf>; Sat, 4 Aug 2001 00:15:35 -0400
Received: from [204.214.10.168] ([204.214.10.168]:49423 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S269787AbRHDEPV>;
	Sat, 4 Aug 2001 00:15:21 -0400
Date: Fri, 3 Aug 2001 23:14:48 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803231448.B15494@xi.linuxpower.cx>
In-Reply-To: <01080317471707.01827@starship> <20010803121638.A28194@cs.cmu.edu> <0108031854120A.01827@starship> <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva> <s5gvgkacqlm.fsf@egghead.curl.com> <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu> <20010803132457.A30127@cs.cmu.edu> <s5g3d78261g.fsf@egghead.curl.com> <20010804051320.B16516@emma1.emma.line.org> <s5gr8usmqkg.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <s5gr8usmqkg.fsf@egghead.curl.com>; from patl@cag.lcs.mit.edu on Fri, Aug 03, 2001 at 11:50:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 11:50:23PM -0400, Patrick J. LoPresti wrote:
> > http://cr.yp.to/qmail/faq/reliability.html
> 
> ...which is consistent.  Qmail is assuming that the link() is
> synchronous, as it was back in the "Good Old Days" of stock FFS.

That isn't the only cruft there from the "Good Old Days":

"Battery backups will keep your server alive, letting you park the disk to
avoid a head crash, when the power goes out."

What the hell? Self-parking drives predate qmail by quite a long time.
