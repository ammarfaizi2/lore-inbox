Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTA2AIj>; Tue, 28 Jan 2003 19:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTA2AIj>; Tue, 28 Jan 2003 19:08:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:58859 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262425AbTA2AIj>;
	Tue, 28 Jan 2003 19:08:39 -0500
Message-ID: <3E371DB1.F365D2CB@digeo.com>
Date: Tue, 28 Jan 2003 16:17:53 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59-dcl2
References: <1043794298.10153.241.camel@dell_ss3.pdx.osdl.net> <1043798822.10150.318.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2003 00:17:53.0369 (UTC) FILETIME=[DD835C90:01C2C72B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> 
> Missed one item in the credits.
> 
> Also, added the Nick Piggin's anticipaatory i/o scheduler (via -mm5)
> to 2.5.59-dcl2 to evaluate the performance impact under different loads.
> 

It caused regression in David Mansfield's database test.  That was
recovered in -mm6.
