Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbUCZPFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbUCZPFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:05:01 -0500
Received: from bay16-f37.bay16.hotmail.com ([65.54.186.87]:65295 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264051AbUCZPE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:04:58 -0500
X-Originating-IP: [12.2.144.2]
X-Originating-Email: [mattreuther@hotmail.com]
From: "Matt Reuther" <mattreuther@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Date: Fri, 26 Mar 2004 10:04:53 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F37GnEErE7noj0001bec0@hotmail.com>
X-OriginalArrivalTime: 26 Mar 2004 15:04:53.0882 (UTC) FILETIME=[B1BBADA0:01C41343]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the real question is this: if this binary blob is not GPL, then how 
can it be in the kernel? It should be pulled out and put in a separate file, 
which can be loaded with the firmware mechanism.

If it is firmware, then would it be legal to reverse engineer the assembler, 
assuming one can find the instruction set for the chip?

Matt

_________________________________________________________________
Get rid of annoying pop-up ads with the new MSN Toolbar – FREE! 
http://toolbar.msn.com/go/onm00200414ave/direct/01/

