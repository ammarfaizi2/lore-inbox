Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271235AbRHTQEm>; Mon, 20 Aug 2001 12:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271329AbRHTQEe>; Mon, 20 Aug 2001 12:04:34 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:3343 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271235AbRHTQEY>;
	Mon, 20 Aug 2001 12:04:24 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 20 Aug 2001 16:01:12 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lrc88$6pv$2@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org> <2251207905.998322034@[10.132.112.53]> <3B8124C4.7A4275B9@nortelnetworks.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998323272 6975 128.32.45.153 (20 Aug 2001 16:01:12 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 20 Aug 2001 16:01:12 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen  wrote:
>Why don't we also switch to a cryptographically secure algorithm for
>/dev/urandom?

/dev/urandom already is using a cryptographically secure algorithm.
Everything you want is already in place.
