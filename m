Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281617AbRKUKS0>; Wed, 21 Nov 2001 05:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKUKSR>; Wed, 21 Nov 2001 05:18:17 -0500
Received: from ns.ithnet.com ([217.64.64.10]:50954 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281563AbRKUKSF>;
	Wed, 21 Nov 2001 05:18:05 -0500
Date: Wed, 21 Nov 2001 11:17:43 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: gallir@uib.es, linux-kernel@vger.kernel.org
Subject: Re: problem with NAT on 2.4
Message-Id: <20011121111743.7d0cd27d.skraw@ithnet.com>
In-Reply-To: <20011120160944.B4124@mikef-linux.matchmail.com>
In-Reply-To: <20011120195443.6842910619@mcrg>
	<20011120211128.1b9ae5fa.skraw@ithnet.com>
	<20011120160944.B4124@mikef-linux.matchmail.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001 16:09:44 -0800
Mike Fedyk <mfedyk@matchmail.com> wrote:

> Did you try running tcpdump on the affected server?

Well, it didn't let me come this far. It just send no packets back at all in
case of not connecting.

But today, the situation is different. I tried several kernels with several
source IPs yesterday night and came to the conclusion that it cannot be a
kernel problem: the same problem arised and vanished on identical disks, but
with different IPs.
So I came to the conclusion that this US-located webhoster in question found a
really nice way to limit traffic by blacklists or some weird IP pattern
matching code, and guess what: _today_ _all_ test configurations _work_.

There are really strange people out there ;-)

This thread is closed.

Thank you for listening. Sorry for wasting your time.

Stephan

