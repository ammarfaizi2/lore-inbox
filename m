Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290324AbSAPBRH>; Tue, 15 Jan 2002 20:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290319AbSAPBQ6>; Tue, 15 Jan 2002 20:16:58 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:3775 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290321AbSAPBQn>;
	Tue, 15 Jan 2002 20:16:43 -0500
Date: Wed, 16 Jan 2002 02:16:34 +0100
From: David Weinehall <tao@acc.umu.se>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, John Weber <weber@nyc.rr.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020116021634.F5235@khan.acc.umu.se>
In-Reply-To: <20020115194425.J17477@redhat.com> <Pine.LNX.4.40.0201151650531.960-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.40.0201151650531.960-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Jan 15, 2002 at 04:52:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 04:52:23PM -0800, Davide Libenzi wrote:
> On Tue, 15 Jan 2002, Benjamin LaHaise wrote:
> 
> > On Tue, Jan 15, 2002 at 04:46:36PM -0800, Davide Libenzi wrote:
> > > after that it builds for me ... but it crashes at boot time
> >
> > Config?  Arch?  Compiler?
> 
> Let me reboot with the crashing kernel for tracing ...
> 
> x86 UP Athlon gcc-3.0.3

Let me suggest gcc-2.95.3 or gcc-2.96-whatever


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
