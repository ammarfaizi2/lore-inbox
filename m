Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266588AbRGQQLs>; Tue, 17 Jul 2001 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266608AbRGQQLi>; Tue, 17 Jul 2001 12:11:38 -0400
Received: from f113.law7.hotmail.com ([216.33.237.113]:65035 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266588AbRGQQL1>;
	Tue, 17 Jul 2001 12:11:27 -0400
X-Originating-IP: [198.252.187.112]
From: "daniel sheltraw" <l5gibson@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PCI and ioports question
Date: Tue, 17 Jul 2001 11:11:25 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1137cu85K9kINc0VUy00019f37@hotmail.com>
X-OriginalArrivalTime: 17 Jul 2001 16:11:25.0502 (UTC) FILETIME=[20DC4DE0:01C10EDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kernel listees

I have a question about ioports on PCI devices but first: If
there is a better mailing list for asking these types of questions
would you kindly direct me there.

The question is this. When do I need to use ioremap for ioports
on a PCI device (PC architecture)? Is the answer: always except
when the physical address is within the 64K - 1M ISA region (legacy
ports).

Thanks,
Daniel
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

