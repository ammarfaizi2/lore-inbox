Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312120AbSCQVNV>; Sun, 17 Mar 2002 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312124AbSCQVNK>; Sun, 17 Mar 2002 16:13:10 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:35471 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312120AbSCQVMz>; Sun, 17 Mar 2002 16:12:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 17 Mar 2002 13:17:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: yodaiken@fsmlabs.com
cc: Daniel Phillips <phillips@bonn-fries.net>, Robert Love <rml@tech9.net>,
        Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
In-Reply-To: <20020316185421.A26719@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0203171316290.7378-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:

> So what didn't you understand? Your (dubious)
> assertion that the lock is "lightweight"
> has absolutely no bearing on whether a lock is needed or not.

more than a lock you better have a preempt disable



- Davide


