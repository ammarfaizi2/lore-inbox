Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRH0WmU>; Mon, 27 Aug 2001 18:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269639AbRH0WmK>; Mon, 27 Aug 2001 18:42:10 -0400
Received: from mean.netppl.fi ([195.242.208.16]:65032 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S269632AbRH0Wl4>;
	Mon, 27 Aug 2001 18:41:56 -0400
Date: Tue, 28 Aug 2001 01:42:11 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A tester is needed with dual P3 and USB
Message-ID: <20010828014211.A29068@netppl.fi>
In-Reply-To: <20010827182204.A25212@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010827182204.A25212@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Aug 27, 2001 at 06:22:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 06:22:04PM -0400, Pete Zaitcev wrote:
> Hi, All:
> 
> I received a complaint that a UP kernel hangs on boot if USB is
> enabled. SMP works. An SMP kernel started with "nosmp" hangs too.
> The reporter is, umm, how shall I put it... is a power user.
> I need someone to help me to track the problem down, because
> I am curious. I heard of SMP hangs before, but a UP hang is
> a novel idea.
> 
> The box is VA Linux 1000 (similar to IBM Netfinity 4000r).
> Kernel is 2.4.8-ac10.
Doesn't VA use one of those Intel boards which have the problem
with theis BIOS, which is seen as a hang with the adaptec driver?

Tried the same work-around? (enabling the APIC)

-- 
Pekka Pietikainen
