Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265363AbUA0T2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUA0T2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:28:13 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:11431 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265363AbUA0T2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:28:07 -0500
Date: Wed, 28 Jan 2004 08:30:09 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT
	problems on Uniwill N258SA0
In-reply-to: <401685F9.6000904@samwel.tk>
To: Bart Samwel <bart@samwel.tk>
Cc: Pavel Machek <pavel@ucw.cz>, Huw Rogers <count0@localnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-laptop@mobilix.org
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1075231649.18386.34.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20040124233749.5637.COUNT0@localnet.com>
 <20040127083936.GA18246@elf.ucw.cz> <401685F9.6000904@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have SMP working under 2.4, and am not far away from having it for
2.6. There is just one file that needs changing, but I need to learn
some x86 assembly first. If someone already knows x86 assembly and wants
to get it going first, I'll happily apply the patch.

Regards,

Nigel

>  > Well, no sleep developers have SMP or HT machines, AFAICT.

-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

