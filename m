Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312356AbSCUPIT>; Thu, 21 Mar 2002 10:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312357AbSCUPH7>; Thu, 21 Mar 2002 10:07:59 -0500
Received: from angband.namesys.com ([212.16.7.85]:8322 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S312356AbSCUPHv>; Thu, 21 Mar 2002 10:07:51 -0500
Date: Thu, 21 Mar 2002 18:07:50 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020321180750.A2706@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020321180117.A2638@namesys.com> <20020321160526.727b0f31.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 21, 2002 at 04:05:26PM +0100, Stephan von Krawczynski wrote:
> > I cannot reproduce it locally, that's it.
> > And if you have reiserfs v3.6 (that's it, not v3.5 converted to 3.6,
> > but v3.6 created with mkreiserfs), then I am out of ideas for you :(
> I never did any conversion. I just don't trust it.

;)

> Maybe my mkreiserfs util is old, and I should try recreating the volumes with a
> newer version? Were there "suspicious" changes during 3.6 format?

Not any I am aware of.

Bye,
    Oleg
