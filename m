Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTLIW6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTLIW6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:58:14 -0500
Received: from mail.netzentry.com ([157.22.10.66]:64529 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S262397AbTLIW6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:58:13 -0500
Message-ID: <3FD65347.6060109@netzentry.com>
Date: Tue, 09 Dec 2003 14:57:11 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: recbo@nishanet.com, linux-kernel@vger.kernel.org
Subject: RE: merged in bk5 Re: Catching NForce2 lockup with NMI watchdog -
 found?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this stuff going to be merged into 2.4 soon? I'd like
to try a 2.4.23/24-bk with these patches.


 >From: Bob
 >Subject: merged in bk5 Re: Catching NForce2 lockup with NMI
 >
 >if you're following this thread, good news--
 >
 >nforce2 fixups have been merged in
 >linux-2.6.0-test11-bk5.patch
 >>  -bk snapshot (patch-2.6.0-test11-bk5)
 >
 >nforce2-disconnect-quirk.patch
 >>  [x86] fix lockups with APIC support on nForce2
 >>
 >>nforce2-apic.patch
 >>  [x86] do not wrongly override mp_ExtINT IRQ
 >
 >plus promise and sis fixes so I don't need to pay
 >for a 3ware controller ;-)   that was another
 >show-stopper for me earlier
 >
 >> We're all trying to get acpi, apic, lapic, io-apic working
 >> when turned on in cmos/bios and kernel.
 >>


