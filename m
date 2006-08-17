Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWHQICp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWHQICp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHQICp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:02:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4115 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932260AbWHQICo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:02:44 -0400
Date: Thu, 17 Aug 2006 10:02:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL Violation?
Message-ID: <20060817080243.GN7813@stusta.de>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <200608170242.40969.diablod3@gmail.com> <1155797656.4494.24.camel@laptopd505.fenrus.org> <200608170332.53556.diablod3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608170332.53556.diablod3@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 03:32:51AM -0400, Patrick McFarland wrote:
> On Thursday 17 August 2006 02:54, Arjan van de Ven wrote:
> > On Thu, 2006-08-17 at 02:42 -0400, Patrick McFarland wrote:
> > > On Thursday 17 August 2006 01:48, Anonymous User wrote:
> > > > I work for a company that will be developing an embedded Linux based
> > > > consumer electronic device.
> > > >
> > > > I believe that new kernel modules will be written to support I/O
> > > > peripherals and perhaps other things.  I don't know the details right
> > > > now.  What I am trying to do is get an idea of what requirements there
> > > > are to make the source code available under the GPL.
> > >
> > > I am not a lawyer, and I suggest your company speak with one before doing
> > > this. (And most likely, someone from the list will correct me if I get
> > > something wrong).
> > >
> > > However, your company only has to release any code they use, preferably
> > > in the form of unmodified tarballs (pointing to project websites for
> > > downloads isn't valid anymore) plus patches against said unmodified
> > > tarballs if modified. If not modified, you still have to release the
> > > unmodified tarballs.
> > >
> > > They don't have to release source code for any module you wrote from
> > > scratch themselves, but said modules cannot say they are GPL (ie, they
> > > have to poison the kernel).
> >
> > Just as a warning: This is your own legal opinion/advice, one which is
> > apparently not shared with many other kernel developers, including me.
> > For example see Greg's OLS keynote:
> > http://www.kroah.com/log/2006/07/23/#ols_2006_keynote
> > or some of Linus' emails on this topic:
> > http://cvs.fedora.redhat.com/viewcvs/*checkout*/rpms/kernel/devel/COPYING.m
> >odules?rev=1.5
> >
> > I hope you have talked to a lawyer about your advice, but I sort of
> > doubt it since your answer doesn't sound like something a lawyer will
> > tell you (it sure doesn't match what the various lawyers I talked to
> > told me, not at all)
> 
> Like I told him, he needs to talk to a lawyer. Also, Linus probably won't 
> agree with me because I said closed source modules are possible. If Linus 
> wants those to not be possible, then hes going to have to change the 
> licensing agreement altogether; which, honestly, I wish he would. 
> 
> Closed source modules are lame, and against the spirit of open source, but 
> that still doesn't make them against the license.

This is _your personal interpretation_ of what consists a "derived work" 
under the GPL.

Other people have other opinions on this issue.

Other people even have asked lawyers that said they'd disagree with 
interpretations like the one you expressed.

If someone needs advice about the legal risks of kernel modules with a 
not GPL compatible licence, he has to ask lawyers knowing the copyright 
laws of the countries he plans to distribute his products to.

This is a known grey area that has AFAIK not yet been brought to court 
in any country, and neither your personal opinion on this issue nor my 
personal opinion on this issue can replace legel advice.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

