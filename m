Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSGYMma>; Thu, 25 Jul 2002 08:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSGYMmZ>; Thu, 25 Jul 2002 08:42:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33035 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293680AbSGYMmX> convert rfc822-to-8bit; Thu, 25 Jul 2002 08:42:23 -0400
Date: Thu, 25 Jul 2002 08:40:01 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
cc: Austin Gonyou <austin@digitalroadkill.net>,
       Patrick Mansfield <patmans@us.ibm.com>, linux-scsi@vger.kernel.org
Subject: Re: Linux Kernel 2.4.18 and 2.4.19 problems
In-Reply-To: <20020719225507.GC14331@stud.ntnu.no>
Message-ID: <Pine.LNX.3.96.1020725083832.11202A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, Thomas [iso-8859-1] Langås wrote:

> Why?  The vanilla kernel works fine with what we have in production,
> but not with the new P4 Dual Xeon.

I know it's not likely to be related in any way, but did you try booting
with hyperthreading off? I believe I saw four CPUs in the stuff you
posted, but it's gone now.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

