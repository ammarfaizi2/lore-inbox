Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTLCBXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTLCBXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:23:49 -0500
Received: from mail.netzentry.com ([157.22.10.66]:48651 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S264461AbTLCBXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:23:46 -0500
Message-ID: <3FCD3B0F.6060700@netzentry.com>
Date: Tue, 02 Dec 2003 17:23:27 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pomac@vapor.com
CC: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is the performance of the generic IDE driver?

My experience that it was almost unusable (kernel 2.4.22,
2.4.23) (fsck taking hours, etc)

 >>>On Wed, 2003-12-03 at 01:58, Allen Martin wrote: -----Original
 >>>Message----- From: Ian Kumlien [mailto:pomac@vapor.com] Sent:
 >>>Tuesday, December 02, 2003 4:47 PM
 >>>
 >>>Well, IDE is what i'd blame. My original experience about lost
 >>>interrupts leads me to ide. Since i never loose interrupts
 >>>without io-apic.
 >>
 >>Can someone who has a system showing this problem try booting
 >>from  a PCI IDE card to see if it makes any difference? I'd try
 >>the experiment here, but I can't reproduce the hanging that's
 >>being reported.

 >Or just to verify boot a kernel without the nvidia/amd ide driver
 >and io-apic enabled.
 >
 > -- Ian Kumlien





