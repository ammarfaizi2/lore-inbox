Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271772AbRHUSSY>; Tue, 21 Aug 2001 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271777AbRHUSSL>; Tue, 21 Aug 2001 14:18:11 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:43526 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271772AbRHUSSE>;
	Tue, 21 Aug 2001 14:18:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 21 Aug 2001 18:14:50 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu8eq$n5v$1@abraham.cs.berkeley.edu>
In-Reply-To: <3B812FD2.836572F5@nortelnetworks.com> <Pine.LNX.4.21.0108211049520.6695-100000@sorbus.navaho>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998417690 23743 128.32.45.153 (21 Aug 2001 18:14:50 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:14:50 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Hill  wrote:
>I was under the impression that urandom was considered insecure [...]

I think there is a perception among certain quarters that it is insecure,
but I also think this perception is completely unjustified.  We don't know
of a single attack, not even an academic weakness.
