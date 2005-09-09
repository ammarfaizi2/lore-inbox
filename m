Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVIIA0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVIIA0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVIIA0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:26:54 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:60398 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965091AbVIIA0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:26:53 -0400
Message-ID: <4320D6CB.2030707@comcast.net>
Date: Thu, 08 Sep 2005 20:26:51 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Ronny V. Vindenes" <s864@ii.uib.no>, roland@redhat.com,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.13-mm2
References: <4KtRD-7Nt-13@gated-at.bofh.it>	<m3slwfxhxd.fsf@localhost.localdomain> <20050908163410.5f1bfc80.akpm@osdl.org>
In-Reply-To: <20050908163410.5f1bfc80.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Parag, perhaps you could confirm that reverting that patch fixes 
> things up?

Sure - reverting the x86-64-ptrace-ia32-bp-fix patch fixes it.

Roland - if seeing backtraces and register info for the failing programs 
is going to help you, please
see the thread "2.6.13-mm1 X86_64: All 32bit programs segfault"

Thanks
Parag
