Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUG0QoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUG0QoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUG0QoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:44:00 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:59622 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266376AbUG0Qnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:43:49 -0400
Date: Tue, 27 Jul 2004 12:36:36 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
In-Reply-To: <20040727173703.0174a76e.ak@suse.de>
Message-ID: <Pine.GSO.4.33.0407271215320.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Andi Kleen wrote:
>> Yes there is a growth;
>>
>>    text    data     bss     dec     hex filename
>> 3655358 1340511  486128 5481997  53a60d vmlinux-after
>> 3648445 1340511  486128 5475084  538b0c vmlinux-before
(diff: 6,913bytes, 0.19% increase)

>That's significant.

6,913bytes is "significant"?  *Now*, after a decade of bloat, you want to
pinch pennies? (Do I need to start the flame war(s) again?  Need I mention
"numcpus"?)

>> 2628024  921731       0 3549755  362a3b vmlinux-after
>> 2621369  921731       0 3543100  36103c vmlinux-before
(diff: 6,655bytes, 0.25% increase)

--Ricky


