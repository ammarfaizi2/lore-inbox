Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280452AbRJaTzD>; Wed, 31 Oct 2001 14:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280453AbRJaTyu>; Wed, 31 Oct 2001 14:54:50 -0500
Received: from marine.sonic.net ([208.201.224.37]:51744 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S280452AbRJaTyl>;
	Wed, 31 Oct 2001 14:54:41 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 31 Oct 2001 11:55:14 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
Message-ID: <20011031115514.F1767@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1004556431.11209.51.camel@mistress> <Pine.LNX.4.33.0110311126500.32727-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110311126500.32727-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 11:38:44AM -0800, Linus Torvalds wrote:
> Then, 2.4.15 would be the point where I start 2.5.x, and where Alan gets
> to do whatever he wants to do with 2.4.x. Including, of course, just
> reverting all my and Andrea's VM changes ;)

There are a lot of patches applied to -ac that are not in the main line.
If many of those are applied to 2.4.16+, would they also be put into the
2.5.x line early in the process so that they will be fairly synced, plus
give you ample time to feel comfortable with their stability?

Especially patches that did not come directly from the maintainers.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
