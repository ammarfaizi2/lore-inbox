Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132628AbRDBIZ0>; Mon, 2 Apr 2001 04:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132629AbRDBIZQ>; Mon, 2 Apr 2001 04:25:16 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:63755 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132628AbRDBIZH>;
	Mon, 2 Apr 2001 04:25:07 -0400
Date: Mon, 2 Apr 2001 10:23:57 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: jerry <jdinardo@ix.netcom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcgetattr fails in 2.4.3
Message-ID: <20010402102357.A16785@pcep-jamie.cern.ch>
In-Reply-To: <20010331191253.A84@ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010331191253.A84@ix.netcom.com>; from jdinardo@ix.netcom.com on Sat, Mar 31, 2001 at 07:12:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerry wrote:
> ppp chat script stopped working under 2.4.3. I ran a program of my own
> that opens ttyS1 and it also fails on a tcgetattr with errno=5 (IO error).
> The ppp chat script and my program both work fine under 2.4.2 and older.

I noticed that, but then I noticed I'm using pppd 2.3.11, and
Documentation/Changes says I should use 2.4.0b1.  Then again
Documentation/Changes said the same thing in kernel 2.4.2 as well, and
pppd 2.3.11 works fine there.

-- Jamie

