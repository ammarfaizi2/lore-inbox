Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293099AbSBWFYN>; Sat, 23 Feb 2002 00:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293100AbSBWFYC>; Sat, 23 Feb 2002 00:24:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293099AbSBWFXo>;
	Sat, 23 Feb 2002 00:23:44 -0500
Message-ID: <3C77270A.1CBA02E8@zip.com.au>
Date: Fri, 22 Feb 2002 21:22:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Justin Piszcz <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C771D29.942A07C2@starband.net>,
		<3C771D29.942A07C2@starband.net>; from war@starband.net on Fri, Feb 22, 2002 at 11:40:09PM -0500 <20020222204456.O11156@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> Try 2.72, it's almost twice as fast as 2.95 for builds.  For BK, at least,
> we don't see any benefit from the slower compiler, the code runs the same
> either way.
> 

Amen.

I want 2.7.2.3 back, but it was the name:value struct initialiser
bug which killed that off.  2.91.66 isn't much slower than 2.7.x,
and it's what I use.

"almost twice as fast"?  That means that 2.7.2 vs 3.x is getting
up to a 3x difference.  Does anyone know why?

[ Of course, if you can wink-in the object file from someone else,
  it's not a problem.  (tum, tee tum...) ]

-
