Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSGRQwZ>; Thu, 18 Jul 2002 12:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSGRQwY>; Thu, 18 Jul 2002 12:52:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27144 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318275AbSGRQwY>; Thu, 18 Jul 2002 12:52:24 -0400
Date: Thu, 18 Jul 2002 12:49:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Piggin, Nick" <Nick.Piggin@cit.act.edu.au>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1,2 + ext3 data=journal: data loss on unmount
In-Reply-To: <C1126026D9293645B970FB72C66907961F53EE@rdmail.cit.act.edu.au>
Message-ID: <Pine.LNX.3.96.1020718124716.8220C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Piggin, Nick wrote:

> I have a PIV server with two IDE disks, one used for the filesystem, the
> other for swap, external journals, and a backup directory.
> 
> All partitions are ext3 data=journal, all but the backup directory have
> external journals. Please mail me for more HW info if needed and I apologise
> if this has already come up (I did search the archives) or is a "known"
> "feature".

Is it related to the external journals? How do you have those set up?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

