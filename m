Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSBDGYv>; Mon, 4 Feb 2002 01:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288593AbSBDGYl>; Mon, 4 Feb 2002 01:24:41 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:37861 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S288579AbSBDGYa>; Mon, 4 Feb 2002 01:24:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Aaron Sethman <androsyn@ratbox.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork  performance
Date: Mon, 4 Feb 2002 07:29:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Dan Kegel <dank@kegel.com>, Kev <klmitch@MIT.EDU>,
        Arjen Wolfs <arjen@euro.net>, <coder-com@undernet.org>,
        <feedback@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0202040121160.3086-100000@simon.ratbox.org>
In-Reply-To: <Pine.LNX.4.44.0202040121160.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020204062429Z16034-10748+186@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 07:26 am, Aaron Sethman wrote:
> On Mon, 4 Feb 2002, Daniel Phillips wrote:
> > In an effort to somehow control the mushrooming number of IO interface
> > strategies, why not take a look at the work Ben and Suparna are doing in aio,
> > and see if there's an interface mechanism there that can be repurposed?
> 
> When AIO no longer sucks on pretty much every platform on the face of the
> planet I think people will reconsider.

What is the hang, as you see it?

> In the mean time, we've got to
> deal with that is there.  That leaves us writing for at least 6 very
> similiar, I/O models with varying attributes.

This is really an unfortunate situation.

-- 
Daniel
