Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRAaM5o>; Wed, 31 Jan 2001 07:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAaM5e>; Wed, 31 Jan 2001 07:57:34 -0500
Received: from [64.22.49.66] ([64.22.49.66]:25106 "EHLO
	phobos.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S129789AbRAaM5S>; Wed, 31 Jan 2001 07:57:18 -0500
Date: Wed, 31 Jan 2001 04:55:15 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: "Michael B. Trausch" <fd0man@crosswinds.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPP broken in Kernel 2.4.1?
In-Reply-To: <Pine.LNX.4.21.0101292100520.460-100000@fd0man.accesstoledo.com>
Message-ID: <Pine.LNX.4.20.0101310453400.18462-100000@phobos.illtel.denver.co.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Michael B. Trausch wrote:

> I'm having a weird problem with 2.4.1, and I am *not* having this problem
> with 2.4.0.  When I attempt to connect to the Internet using Kernel 2.4.1,
> I get errors about PPP something-or-another, invalid argument.  I've tried

  Upgrade ppp to 2.4.0b1 or later -- it's documented in 
Documentation/Changes.

-- 
Alex

----------------------------------------------------------------------
 Excellent.. now give users the option to cut your hair you hippie!
                                                  -- Anonymous Coward

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
