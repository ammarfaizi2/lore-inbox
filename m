Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbUJ2TtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUJ2TtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbUJ2Tqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:46:46 -0400
Received: from bay23-f15.bay23.hotmail.com ([64.4.22.65]:21963 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261996AbUJ2TYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:24:04 -0400
X-Originating-IP: [64.90.198.61]
X-Originating-Email: [jocosby@hotmail.com]
From: "Joseph Cosby" <jocosby@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Call to mmap Failing in SVGALIB
Date: Fri, 29 Oct 2004 13:23:05 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY23-F15BIXnnGvgnt0002a704@hotmail.com>
X-OriginalArrivalTime: 29 Oct 2004 19:24:03.0258 (UTC) FILETIME=[D985E9A0:01C4BDEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, I've just started using the 2.6.9 kernel in place of the 2.6.7 kernel 
and now the vga_init call into svgalib is failing. The problem appears to be 
a call to mmap inside the library. Since I see in the change log that there 
have been changes, and fixes to changes, in mmap, I suspect that this is a 
problem with the new kernel, and not the svgalib.
  Are there any kernel config options that might be a help in using the 
older mmap or perhaps there are some options that configure mmap usage? I 
didn't see any.
  I haven't provided any too detailed information, in case nobody is 
interested. But if somebody is interested in knowing how this is failing 
then I'll supply more details.

Thanks,
Joseph

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

