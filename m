Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTCKTy3>; Tue, 11 Mar 2003 14:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbTCKTy3>; Tue, 11 Mar 2003 14:54:29 -0500
Received: from citi.umich.edu ([141.211.92.141]:4410 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S261568AbTCKTy1>;
	Tue, 11 Mar 2003 14:54:27 -0500
Date: Tue, 11 Mar 2003 15:04:58 -0500
From: Niels Provos <provos@citi.umich.edu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030311200457.GE9975@citi.citi.umich.edu>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <20030311043202.GK2225@citi.citi.umich.edu> <Pine.LNX.4.50.0303111013020.1855-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303111013020.1855-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 10:15:10AM -0800, Davide Libenzi wrote:
> Niels, can you publish inside the libevent web site the library that has
> epoll inside ( possibly with the changes I made to epoll_create() ) ? I'm
> including the test application, so other can repeat tests if they want.
I just put up a snapshot at

  http://naughty.monkey.org/~provos/libevent-snapshot.tar.gz

that includes the benchmark.

Niels.
