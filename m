Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTK1JHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTK1JHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:07:39 -0500
Received: from ns.tasking.nl ([195.193.207.2]:62732 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S262076AbTK1JHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:07:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9/10 speedtouch glitch
Organization: Altium SOFTWARE B.V.
References: <200311272023.56413.vlad@lazarenko.net> <200311272143.05662.baldrick@free.fr> <200311272339.26205.vlad@lazarenko.net> <200311272339.26205.vlad@lazarenko.net> <200311280001.30220.baldrick@free.fr>
X-Face: "A(HPX!owGRCdtOX\NKs=ac*&x%/sYJMc;M<L&"^kH9ogp5;"w#UVc0yt3K{@n#.E+=k>qd bqZYYQvB9_xdS1l+B2\z;:p71RNxrja;ir>Dj?6%GzFA!o>gOL&G}8X;icnhqP|=TU,O@JVM%5LL:X ,G&IkRk9n%h7hZFUltu%RB=ctrdfu?[vSRV%Wzcn;#o>[K0C6_'q*~^+toc))w-Qb8*,afMHVCrNG6
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <spam@altium.nl>
Date: 28 Nov 2003 10:06:22 +0100
Message-ID: <siwu9kuak1.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Duncan Sands writes:
> 
> On Thursday 27 November 2003 23:39, Vladimir Lazarenko wrote:
>> 
>> Using Debian/sid with latest available usbmgr.
>> Tho the module itself loads successfully, just that modem_run isn't able to
>> see the device, I think at that point hotplug has to complete already?
> 
> What error message do you get exactly?  When running what command?

I always thought that modem_run (the user-space driver) and the kernel
driver don't match. Am I wrong?

		Kees

