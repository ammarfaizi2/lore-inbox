Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUIKVhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUIKVhK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268337AbUIKVhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:37:10 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:49789 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268336AbUIKVhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:37:03 -0400
Message-ID: <9e47339104091114374b9545f5@mail.gmail.com>
Date: Sat, 11 Sep 2004 17:37:02 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <20040911220614.A5023@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091010221f03ec06@mail.gmail.com>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911105448c3f089@mail.gmail.com>
	 <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
	 <9e4733910409111402138737aa@mail.gmail.com>
	 <20040911220614.A5023@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 22:06:14 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Sep 11, 2004 at 05:02:36PM -0400, Jon Smirl wrote:
> > Alan, if you will commit Redhat to implementing all of the features
> > referenced in this message:
> 
> You definitly start sounding like Hans ;-)

Getting the Linux display subsystem to a point where it can compete
with Longhorn/Mac is a very complicated problem. It is going to take
several years of work and the cooperation of a lot of people. It's a
pyramid problem with lot's of layers.

Of course Linux can choose not to build a display system based on 3D
hardware. But I've seen the
current Longhorn/Mac implementations and they are way, way better than
X. If Linux ignores 3D mode it is going to be very visible on the
desktop.

I've tried to follow the Linux model for proposing the changes. The
plan has been circulated to all relevant lists: fbdev, dri, xorg, lkml
for over six months. Three sessions at OLS talked about various parts
of the plan. Nothing has been kept secret, there must be 5,000
messages in the archive on this subject.

But since I've written most of the code so far I get to pick the
details of the implementation. If Alan would instead like to pick the
details I've offered to withdraw if he'll write the code needed to
implement the major points of the plan. Of course if Redhat wants to
send me a check for a couple of hundred thousand dollars I'll write
whatever they want, but they haven't done that.

-- 
Jon Smirl
jonsmirl@gmail.com
