Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTKEAFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 19:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTKEAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 19:05:34 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2833
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262109AbTKEAFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 19:05:31 -0500
Date: Tue, 4 Nov 2003 16:05:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: reiser@namesys.com, herbert@gondor.apana.org.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031105000518.GA32687@matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	reiser@namesys.com, herbert@gondor.apana.org.au, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031104210310.GA1068@matchmail.com> <20031105004956.19dbd3fb.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105004956.19dbd3fb.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 12:49:56AM +0100, Stephan von Krawczynski wrote:
> On Tue, 4 Nov 2003 13:03:10 -0800
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
> > There was a bug in one of the released Debian kernels, and do you think this
> > hasn't happened with Redhat, SuSe, or Mandrake?  Just because Debian is
> > completely OSS and maintained mostly by unpaid volunteers, that shouldn't
> > keep them from having a seperate tree like everyone else.
> 
> Just to avoid a false impression: I am in no way against debian project nor do
> I say there is anything specifically bad about it. I am generally disliking
> distros' ideas of having _own_ kernels. Commercial companies like SuSE or Red
> Hat may find arguments for that which are commercially backed, debian on the
> other hand can hardly argue commercially. From the community point of view it
> is just nonsense. It means more work and less useable feedback.
> Bugs is distro kernels are (always) the sole fault of their respective
> maintainers because they actively decided _not_ to follow the mainstream and
> made bogus patches. Why waste the appreciated work of (unpaid) debian
> volunteers in this area? There are tons of other work left with far more
> relevance for users than bleeding edge kernel patches...

I agree with you for the most part.

Herbert did say he submitted patches for the parts that were ready.  He
didn't say if he was working with Bart and Alan on the IDE changes though.

I haven't seen any messages from him on lkml with "patch" in the subject,
but that doesn't mean he's not working with the maintianers.

Herb, what do you have to say on this?
