Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281485AbRKZHPj>; Mon, 26 Nov 2001 02:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281487AbRKZHP3>; Mon, 26 Nov 2001 02:15:29 -0500
Received: from otter.mbay.net ([206.40.79.2]:48144 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S281485AbRKZHPQ> convert rfc822-to-8bit;
	Mon, 26 Nov 2001 02:15:16 -0500
From: John Alvord <jalvo@mbay.net>
To: John Jasen <jjasen1@umbc.edu>
Cc: David Relson <relson@osagesoftware.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
Date: Sun, 25 Nov 2001 23:15:09 -0800
Message-ID: <aiq30ukbtppbtu3kt40addk05kbqvp1i4b@4ax.com>
In-Reply-To: <Pine.LNX.4.20.0111242147500.26049-100000@otter.mbay.net> <Pine.SGI.4.31L.02.0111250907550.12928198-100000@irix2.gl.umbc.edu>
In-Reply-To: <Pine.SGI.4.31L.02.0111250907550.12928198-100000@irix2.gl.umbc.edu>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001 09:12:10 -0500, John Jasen <jjasen1@umbc.edu>
wrote:

>On Sat, 24 Nov 2001, John Alvord wrote:
>
>> Development kernels are development kernels... nothing else. Look to
>> distributors for high degrees of quality assurance testing. When you run a
>> development kernel you have joined the development team, even if you don't
>> know it. Finding  and reporting bugs is your job...
>
>That's why you stay away from 2.5.x, or 2.4.x-pre, or 2.4.x-ac -- which
>are development kernels. 2.4.x kernels are released kernels.

2.<even>.x are "stablizing" kernels, where (theoretically) only bug
fixes are accepted. But the code hasn't been through any QA cycle at
the moment of release. It is still a developer release in any
traditional software development definition.

I am quite impressed that Linus hangs on to the initial x.<even>
series until it becomes close to production quality. Notice that an
important user (google) came up with a severe error very late in the
day and Linus held things up for a few weeks until that was cleared.
Notice the months long struggle to decide on a VM solution. In this
cycle, it took maybe ten months to shepard 2.4.0 into something of
excellent potential that is a real step forward from the 2.2 series.

 Everyone who participated can be proud.

john alvord
