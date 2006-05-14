Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWENHqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWENHqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWENHqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:46:38 -0400
Received: from dze141s31.ae.poznan.pl.220.254.150.in-addr.arpa ([150.254.220.184]:12468
	"EHLO dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S1751370AbWENHqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:46:37 -0400
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.6 AWL                    AWL: From: address is in the auto white-list
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(85.221.144.160):SA:0(-3.3/3.0):. Processed in 0.90464 secs Process 29286)
Date: Sun, 14 May 2006 09:46:39 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <9510556356.20060514094639@dns.toxicfilms.tv>
To: Greg KH <greg@kroah.com>
CC: Adrian Bunk <bunk@stusta.de>, Ingo Oeser <ioe-lkml@rameria.de>,
       Chris Wright <chrisw@sous-sol.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16.16
In-Reply-To: <20060514035937.GA6498@kroah.com>
References: <20060511022547.GE25010@moss.sous-sol.org> <296295514.20060511123419@dns.toxicfilms.tv> <20060511173312.GI25010@moss.sous-sol.org> <200605131735.20062.ioe-lkml@rameria.de> <20060513155610.GB6931@stusta.de> <7c3341450605131029l194174f3v7339dce0e234b555@mail.gmail.com> <20060514035937.GA6498@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Sunday, May 14, 2006, 5:59:37 AM, you wrote:
> To be fair, the extra work of writing out a detailed exploit, complete
> with example code, for every security update, would just take way too
> long.
Well, I think what we meant is just a one-liner hint from a wise developer
suggesting some action, meaning something like: "This one I recommend to all"
or "Use this if you use SCTP" or "X can do nasty things, you should upgrade
if you are using it". If the patch title is "Fix a buffer overflow in foo"
everybody knows what to do, but when it says "Fix foo so that baz stays barred"
an additional hint would be nice, because it's ambiguous for someone
just tracking stable releases and not being knowledgible enough to decide
whether baz is a function or system call that they are using.

I was not suggesting full detailed reports, I know the developers have better
things to do, just some hints :-)

-- 
Best regards,
Maciej


