Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312355AbSCUPBt>; Thu, 21 Mar 2002 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312356AbSCUPBk>; Thu, 21 Mar 2002 10:01:40 -0500
Received: from angband.namesys.com ([212.16.7.85]:4994 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S312355AbSCUPBW>; Thu, 21 Mar 2002 10:01:22 -0500
Date: Thu, 21 Mar 2002 18:01:17 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020321180117.A2638@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020315150536.A2279@namesys.com> <20020321154500.117e8acc.skraw@ithnet.com> <20020321155731.2490f859.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 21, 2002 at 03:57:31PM +0100, Stephan von Krawczynski wrote:

> 2) the problem _is_ dependant on the fs mounted in the following form:
> mounting two fs that are located on the _same_ reiserfs _works_.
> mounting two fs that are located on _different_ reiserfs _does not work_.
> How about that?

I cannot reproduce it locally, that's it.
And if you have reiserfs v3.6 (that's it, not v3.5 converted to 3.6,
but v3.6 created with mkreiserfs), then I am out of ideas for you :(

Bye,
    Oleg
