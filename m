Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVDGTp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVDGTp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVDGTp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:45:26 -0400
Received: from bay101-f35.bay101.hotmail.com ([64.4.56.45]:9953 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262574AbVDGTpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:45:21 -0400
Message-ID: <BAY101-F359BCA56656D2AFE6BA4BCDC3E0@phx.gbl>
X-Originating-IP: [64.4.56.200]
X-Originating-Email: [danieljlaird@hotmail.com]
In-Reply-To: <20050407185901.GA26850@linux-mips.org>
From: "Daniel Laird" <danieljlaird@hotmail.com>
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: mipsel-linux-ld vmlinux.lds:470: Parse Error
Date: Thu, 07 Apr 2005 19:45:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Apr 2005 19:45:20.0119 (UTC) FILETIME=[54AF7070:01C53BAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@vger.kernel.org

From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Laird <danieljlaird@hotmail.com>
Subject: Re: mipsel-linux-ld vmlinux.lds:470: Parse Error
Date: Thu, 7 Apr 2005 19:59:01 +0100

On Thu, Apr 07, 2005 at 05:58:20PM +0000, Daniel Laird wrote:

 > I am trying to build a linux kernel and toolchain for a le mips processor
 >
 > I have the following versions
 > binutils-2.15.96
 > gcc-3.4.3
 > glibc-2.3.4
 > linux kernel 2.6.11.6

Is there a reason for this?
we have our own patches that we apply (include, asm-mips, pci, irqs, serial 
etc) and they have worked for 2.6.8 and 2.6.10 however if you think that the 
linux-mips people will have fixed more of these bugs than me (and this 
specific one)  then i shal try their 2.6.11 kernel.
cheers
Dan


