Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSFFRiA>; Thu, 6 Jun 2002 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317032AbSFFRh7>; Thu, 6 Jun 2002 13:37:59 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11311 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317030AbSFFRh7>; Thu, 6 Jun 2002 13:37:59 -0400
Date: Thu, 6 Jun 2002 13:37:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200206061737.g56Hbws24655@devserv.devel.redhat.com>
To: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <mailman.1023370621.16639.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> Of course, the situation is particularly bad on s390, because every
> function call needs at least 96 bytes on the stack (due to the register
> save areas required by our ABI).

How is this different from sparc64?

-- Pete
