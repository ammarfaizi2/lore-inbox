Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310201AbSCVFs0>; Fri, 22 Mar 2002 00:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311294AbSCVFsQ>; Fri, 22 Mar 2002 00:48:16 -0500
Received: from angband.namesys.com ([212.16.7.85]:35716 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S310201AbSCVFsE>; Fri, 22 Mar 2002 00:48:04 -0500
Date: Fri, 22 Mar 2002 08:48:00 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020322084800.A6792@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020321180750.A2706@namesys.com> <20020321181516.24ea3fbd.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 21, 2002 at 06:15:16PM +0100, Stephan von Krawczynski wrote:

> It now works, depending on which fs I mount first. Remeber both are completely
> new 3.6 fs. I can really reproduce mounting "a", then "b" works, but first
> mounting "b", then "a" has the problem. Did you try something like this (play
> with the mounting sequence)?

Yes, I tried to change order of mounts with no apparent success (or perhaps
failure).

Bye,
    Oleg 
