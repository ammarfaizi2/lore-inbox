Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264103AbRF1T6Z>; Thu, 28 Jun 2001 15:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264193AbRF1T6F>; Thu, 28 Jun 2001 15:58:05 -0400
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:37077 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S264103AbRF1T6C>; Thu, 28 Jun 2001 15:58:02 -0400
Message-ID: <3B3B8C47.D1363D6F@bigfoot.com>
Date: Thu, 28 Jun 2001 12:57:59 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20p6ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Pierre Etchemaite <petchema@concept-micro.com>
Subject: Re: AMD thunderbird oops
In-Reply-To: <XFMail.20010628145528.petchema@concept-micro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some ASUS boards (mostly P3B-F) would either freeze or self reboot when using
> PhotoShop 5. Everything else would run perfectly.
> 
> Disabling MMX optimizations in this software would "solve" the problem. Another
> solution found on the web (sorry, I don't have the URL at hand) is to add two
> or three additionnal capacitors on the back of the board, to solve the electric
> instabilities that cause the reboots.

This is incorrect information.  Abit BP6 early revs suffered under load
from a 100uF cap (EC10, between the CPU sockets) that should have been
1500uF.  This was compounded by a weak or otherwise inadequate power
supply.

Having run literally 7 P3F-Fs and 6 of their P2B-F predecessors, not a
single one had any problems.  They were the premiere overclocking boards
of their day.

rgds,
Tim.

--
