Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVJ1PcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVJ1PcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVJ1PcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:32:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27553 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030210AbVJ1PcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:32:14 -0400
To: Vladimir Lazarenko <vlad@lazarenko.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
References: <4361408B.60903@lazarenko.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 28 Oct 2005 09:30:51 -0600
In-Reply-To: <4361408B.60903@lazarenko.net> (Vladimir Lazarenko's message of
 "Thu, 27 Oct 2005 23:03:07 +0200")
Message-ID: <m1irvhbqvo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Lazarenko <vlad@lazarenko.net> writes:

> Hello,
>
> Looking at the thread of Interl Dual-core and 4GB a sudden thought came to my
> mind: "Hey, I'm gonna upgrade my box to 4G next week too... Would it work?"
>
> Thus, the question - would I be able to use whole 4G RAM with dual-core amd and
> kernel with SMP compiled for i686?

A Dual-core is a rev-E processor so the cpu has memory hoisting support,
so it will work if your BIOS implement it properly.

Eric
