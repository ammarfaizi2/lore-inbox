Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280070AbRJaEvF>; Tue, 30 Oct 2001 23:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280071AbRJaEuz>; Tue, 30 Oct 2001 23:50:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:39656 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280070AbRJaEuf>; Tue, 30 Oct 2001 23:50:35 -0500
Date: Tue, 30 Oct 2001 21:50:12 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030215012.C1037@w-mikek2.sequent.com>
In-Reply-To: <20011030212940.A1037@w-mikek2.sequent.com> <Pine.LNX.4.40.0110302044030.1495-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0110302044030.1495-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Oct 30, 2001 at 08:45:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 08:45:02PM -0800, Davide Libenzi wrote:
> On Tue, 30 Oct 2001, Mike Kravetz wrote:
> 
> > On Tue, Oct 30, 2001 at 05:06:16PM -0800, Davide Libenzi wrote:
> > > On Tue, 30 Oct 2001, Mike Kravetz wrote:
> > > > --------------------------------------------------------------------
> > > > Chat - VolanoMark simulator.  Result is a measure of throughput.
> > > >        Higher is better.
> > > > --------------------------------------------------------------------
> > >
> > > How does this test work exactly ?
> >
> > This is basically a message passing (via sockets) benchmark with
> > high thread counts/runqueue lengths.
> 
> Are threads pre-created at startup or are dynamic ?

They are pre-created at startup.

-- 
Mike
