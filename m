Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbTLNFKG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 00:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265350AbTLNFKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 00:10:06 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:707 "EHLO smtp1.clear.net.nz")
	by vger.kernel.org with ESMTP id S265346AbTLNFKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 00:10:02 -0500
Date: Sun, 14 Dec 2003 17:38:10 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: RFC: Can swsusp 2.0 be merged into the 2.4 tree
In-reply-to: <20031212192252.GA465@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1071376690.2187.25.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200312110537.17496.mhf@linuxmail.org>
 <20031212192252.GA465@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's a bit rough, isn't it Pavel? I fully agree that the power
management support in 2.4 is incomplete (just as is the case in 2.6),
but there is power management support in 2.4, and it is being used.

Regards,

Nigel

On Sat, 2003-12-13 at 08:22, Pavel Machek wrote:
> Hi!
> 
> > swsusp is useful feature also for 2.4. Could this please be merged.
> 
> 2.4 has no driver model => swsusp for 2.4 is a hack. Its nice and
> working, but it is still a hack.
> 							Pavel
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

