Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSJaPln>; Thu, 31 Oct 2002 10:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSJaPln>; Thu, 31 Oct 2002 10:41:43 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51347 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262528AbSJaPlm>;
	Thu, 31 Oct 2002 10:41:42 -0500
Date: Thu, 31 Oct 2002 16:48:08 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021031154808.GA4054@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021031005259.GA25651@bjl1.asuk.net> <Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com> <20021031154112.GB27801@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031154112.GB27801@bjl1.asuk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 03:41:12PM +0000, Jamie Lokier wrote:

> There are several scalable and fast event queuing mechanisms in the
> kernel now: rt-signals, aio and epoll, yet each of them is limited by
> only keeping track of a few kinds of possible event.

Probably you could even abuse netlink for this purpose. netlink for kqueue?

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
