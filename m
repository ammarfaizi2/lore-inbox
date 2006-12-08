Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424690AbWLHFuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424690AbWLHFuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 00:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424711AbWLHFuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 00:50:08 -0500
Received: from smtp42.singnet.com.sg ([165.21.103.146]:38268 "EHLO
	smtp42.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424707AbWLHFuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 00:50:06 -0500
Message-ID: <4578FD41.7060808@homeurl.co.uk>
Date: Fri, 08 Dec 2006 13:50:57 +0800
From: Bob <spam@homeurl.co.uk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 SMP very slow with ServerWorks LE Chipset
References: <4577AA11.6020906@homeurl.co.uk> <1165490120.27217.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1165490120.27217.4.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> in UP config everything is OK in SMP the system slows right down, 
>> I've been searching and recompiling my kernel for days looking for 
>> the problem option without success, please help.
> 
> does the linux-ready firmware kit work on this machine? (see url in
> sig), it might be something with the mtrr's, and the kit checks those...

It runs OK though the system seems to fail a lot of tests.
http://www.homeurl.co.uk/linuxfirmwarekit/results.xml
http://www.homeurl.co.uk/linuxfirmwarekit/resources.xml
infact the complete contents of the USB thumb drive are here
http://www.homeurl.co.uk/linuxfirmwarekit/

If you see my other post, booting in SMP and decompressing the kernel 
tree on CPU 0 took 1m 35s, and CPU 1 still hadn't finished in 40m when I 
killed it to run the LFDK.

I'm running the latest HP BIOS and I don't think it's possible to put 
the ASUS one on, any idea what I can do to fix it?

Thank you for your help.
