Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSAFD4X>; Sat, 5 Jan 2002 22:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSAFD4D>; Sat, 5 Jan 2002 22:56:03 -0500
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:6160 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S287676AbSAFDzx>; Sat, 5 Jan 2002 22:55:53 -0500
Message-ID: <3C37CA9F.265406B3@easynet.be>
Date: Sun, 06 Jan 2002 04:55:11 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9-O1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201060516090.6357-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> against -pre9:
> 
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-B4.patch
> 
>         Ingo

Ingo,

I am running 2.5.2-pre9 with your -B4 patch since more or less 1 hour.
I have done a little stress testing, seems OK: no crash, no freeze.

-- 
Luc Van Oostenryck
