Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271533AbTGQWJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271557AbTGQWJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:09:10 -0400
Received: from [213.13.155.14] ([213.13.155.14]:34316 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S271533AbTGQWJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:09:07 -0400
Subject: Re: SET_MODULE_OWNER
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: davem@redhat.com
Cc: jgarzik@pobox.com, schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org
In-Reply-To: <20030717144031.3bbacee5.davem@redhat.com>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	 <3F16C190.3080205@pobox.com> <200307171756.19826.schlicht@uni-mannheim.de>
	 <3F16C83A.2010303@pobox.com> <20030717125942.7fab1141.davem@redhat.com>
	 <1058477803.754.11.camel@ezquiel.nara.homeip.net>
	 <20030717144031.3bbacee5.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1058480636.754.31.camel@ezquiel.nara.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jul 2003 23:23:57 +0100
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: zmail.pt, Thu, 17 Jul 2003 23:30:32 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 22:40, David S. Miller wrote:
> That's a bug we need to fix.
> 
> What driver are you using?
> Are you using ipv6?
> Any netfilter modules?
> Anything else interesting or "unique" about your particular setup?

Sorry, I forgot. Cooking and mailing just don't mix.

Debian SID, Kernel v2.6.0-test1, compiled with GCC3.3, on a Athlon 850.
The driver is 8139too, for the RealTek8139 (no special options).
Netfilter no, IPv6 yes.

XFS, ALSA (emu10k1), OSS emulation, SCSI emulation are also in the mix.
And I did check this behaviour without running X (yet another kernel
tainted by nvidia here).
Can't rember anything else in particular..

-- 
	Ricardo

