Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVCNJy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVCNJy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVCNJy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:54:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:31181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262099AbVCNJxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:53:46 -0500
Date: Mon, 14 Mar 2005 01:53:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Stark <gsstark@MIT.EDU>
Cc: gsstark@MIT.EDU, s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org,
       pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Message-Id: <20050314015321.5e944d84.akpm@osdl.org>
In-Reply-To: <87u0nevc11.fsf@stark.xeocode.com>
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
	<20050313200753.20411bdb.akpm@osdl.org>
	<87br9m7s8h.fsf@stark.xeocode.com>
	<87zmx66b2b.fsf@stark.xeocode.com>
	<87u0nevc11.fsf@stark.xeocode.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark <gsstark@MIT.EDU> wrote:
>
>  > Greg Stark <gsstark@MIT.EDU> writes:
>  > 
>  > > Andrew Morton <akpm@osdl.org> writes:
>  > > 
>  > > > Are you able to narrow it down to something more fine grained than "between
>  > > > 2.6.6 and 2.6.9-rc1"?
>  > > 
>  > > Er, I suppose I would have to build some more kernels. Ugh. Is there a good
>  > > place to start or do I have to just do a binary search?
> 
>  Well, I built a slew of kernels but found it on the first reboot.
> 
>  2.6.7 doesn't work.
> 
>  I compiled the 2.6.6 drivers for 2.6.10 but they give ENODEV when I load them.
> 

Herbert tells me that this might be fixed in 2.6.11.  Did you try that?
