Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSGaUVH>; Wed, 31 Jul 2002 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318501AbSGaUVH>; Wed, 31 Jul 2002 16:21:07 -0400
Received: from pat.uio.no ([129.240.130.16]:58515 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318488AbSGaUVG>;
	Wed, 31 Jul 2002 16:21:06 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
References: <3D3761A9.23960.8EB1A2@localhost>
	<Pine.LNX.3.96.1020731133038.10066A-100000@gatekeeper.tmr.com>
	<20020731185850.A20614@infradead.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 31 Jul 2002 22:20:41 +0200
In-Reply-To: <20020731185850.A20614@infradead.org>
Message-ID: <shsk7nbps2u.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@infradead.org> writes:

     > On Wed, Jul 31, 2002 at 01:43:15PM -0400, Bill Davidsen wrote:
    >> > o Add support for NFS v4
    >>
    >> Sorry to repeat, this seems to be a feature which will be in
    >> many if not most other systems before any possible release date
    >> for 2.8. Is it really that far out? (that's a status request,
    >> not a statement)

     > Given that work on a GPL-compatible NFSv4 implementation hasn't
     > even started yet as far as I know it's very unlikely that it
     > will be in 2.6.0.

In that case I suggest you check the Linux Kernel archives again. The
CITI folks have been working on this for at least 2 years now. There
are beta versions both for Linux, and BSD, and the former has indeed
been announced both on this list and on the Linux Fsdevel list.

IIRC, the GPLed version was in fact pretty much of a necessity in
order to get the IETF to consider NFSv4 as an internet standard: for
that you need at least 2 independent implementations (SunOS + Linux
are the showcases)

Cheers,
  Trond
