Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTKDXuD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 18:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTKDXuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 18:50:03 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:9864 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262106AbTKDXt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 18:49:59 -0500
X-Sender-Authentication: net64
Date: Wed, 5 Nov 2003 00:49:56 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: reiser@namesys.com, herbert@gondor.apana.org.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer
 error at fs/buffer.c:431"
Message-Id: <20031105004956.19dbd3fb.skraw@ithnet.com>
In-Reply-To: <20031104210310.GA1068@matchmail.com>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
	<20031101233354.1f566c80.akpm@osdl.org>
	<20031102092723.GA4964@gondor.apana.org.au>
	<20031102014011.09001c81.akpm@osdl.org>
	<20031104210310.GA1068@matchmail.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 13:03:10 -0800
Mike Fedyk <mfedyk@matchmail.com> wrote:

> There was a bug in one of the released Debian kernels, and do you think this
> hasn't happened with Redhat, SuSe, or Mandrake?  Just because Debian is
> completely OSS and maintained mostly by unpaid volunteers, that shouldn't
> keep them from having a seperate tree like everyone else.

Just to avoid a false impression: I am in no way against debian project nor do
I say there is anything specifically bad about it. I am generally disliking
distros' ideas of having _own_ kernels. Commercial companies like SuSE or Red
Hat may find arguments for that which are commercially backed, debian on the
other hand can hardly argue commercially. From the community point of view it
is just nonsense. It means more work and less useable feedback.
Bugs is distro kernels are (always) the sole fault of their respective
maintainers because they actively decided _not_ to follow the mainstream and
made bogus patches. Why waste the appreciated work of (unpaid) debian
volunteers in this area? There are tons of other work left with far more
relevance for users than bleeding edge kernel patches...

And if you really insist to pick up the tough pieces around kernel then find
out why 2.4.20 is the last stable netfilter implementation... for sure far more
relevant than loadable module ide code in 2.6.0-testX.

Regards,
Stephan
