Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272165AbRH3Lm0>; Thu, 30 Aug 2001 07:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272166AbRH3LmG>; Thu, 30 Aug 2001 07:42:06 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:13842 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S272165AbRH3Ll6>;
	Thu, 30 Aug 2001 07:41:58 -0400
Message-ID: <20010830154914.A13392@castle.nmd.msu.ru>
Date: Thu, 30 Aug 2001 15:49:14 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: John paul R <jpr200012@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell inspiron 8000 eepro100 problems
In-Reply-To: <20010822080412.33733.qmail@web9307.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010822080412.33733.qmail@web9307.mail.yahoo.com>; from "John paul R" on Wed, Aug 22, 2001 at 01:04:12AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 01:04:12AM -0700, John paul R wrote:
[snip]
> sometimes it may take 10 hours to start. what happens
> is i lose my ability to connect to anything whether it
> be telnet, web browsing, ssh, etc. but i can still
> ping sites by ip address. if i am plugged in behind my
> router i can ping and connect to other boxes on my
> network (i've been browsing through a proxy on one of
> them while trying to figure out what the problem is).
[snip]

The fact that you can still ping sites by IP is important.
1. Check if it's DNS-related problem.
2. Check if packet size matters.

	Andrey
