Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131411AbRC0Qmn>; Tue, 27 Mar 2001 11:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131415AbRC0Qme>; Tue, 27 Mar 2001 11:42:34 -0500
Received: from [195.63.194.11] ([195.63.194.11]:21773 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131411AbRC0Qm0>; Tue, 27 Mar 2001 11:42:26 -0500
Message-ID: <3AC0BFEB.5E81FAB1@evision-ventures.com>
Date: Tue, 27 Mar 2001 18:29:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
In-Reply-To: <l03130337b6e65e809070@[192.168.239.101]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:

> 
> Oh and BTW, I think Bit/sqr(seconds) is a perfectly acceptable unit for
> "badness".  Think about it - it increases with pigginess and decreases with
> longevity.  I really don't see a problem with it per se.

Right it's not a problem pre se, but as you already explained
the problem is in the weightinig of different factors.
It's a matter of principle.
