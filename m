Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283265AbRLWCw7>; Sat, 22 Dec 2001 21:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283269AbRLWCwt>; Sat, 22 Dec 2001 21:52:49 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:32337 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283265AbRLWCwj>; Sat, 22 Dec 2001 21:52:39 -0500
Date: Sat, 22 Dec 2001 21:52:31 -0500
From: Bill Nottingham <notting@redhat.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, sfr@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg ?
Message-ID: <20011222215231.B19358@nostromo.devel.redhat.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, sfr@gmx.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011222083457.GA666@asterix> <20011222.155713.84363957.davem@redhat.com> <20011223004434.A19313@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223004434.A19313@conectiva.com.br>; from acme@conectiva.com.br on Sun, Dec 23, 2001 at 12:44:34AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo (acme@conectiva.com.br) said: 
> Em Sat, Dec 22, 2001 at 03:57:13PM -0800, David S. Miller escreveu:
> > What compiler are you using to build these kernels?  To be honest
> > the assertion you have triggered ought to be impossible and this is
> > the first report I've ever seen of it triggering.
> 
> IIRC he said he (or another guy with the same problem) was using gcc
> 3.0.something available in Red Hat rawhide.

If it's the one in rawhide, it's 3.1-0.10, off gcc HEAD. I have yet
to see a kernel boot successfully compiled by this compiler, but
YMMV. :)

Bill
