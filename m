Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVDOPN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVDOPN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDOPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:13:18 -0400
Received: from [81.2.110.250] ([81.2.110.250]:1991 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261836AbVDOPMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:12:30 -0400
Subject: Re: security issue: hard disk lock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonas Diemer <diemer@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200504111801.16647.diemer@gmx.de>
References: <200504041942.10976.diemer@gmx.de>
	 <1113233800.9875.47.camel@localhost.localdomain>
	 <200504111801.16647.diemer@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113577779.11116.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Apr 2005 16:09:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-04-11 at 17:01, Jonas Diemer wrote:
> Yes, but a new video-card or Motherboard can be easily bought (although it 
> costs), but the data on a locked disk is lost forever, unless you pay for 
> professional recovery (which is also a time-issue, if time critical data is 
> stored on the disk). Of course, this can be solved with a good backup 
> strategy...

It still causes great inconvenience I agree. 

> I agree with you though, that this really isn't a kernel issue, but a BIOS 
> thing. Distributors should/could provide additional security by freezing the 
> security-features early during boot, until BIOS vendors do their homework.

Its really for Jeff and Bartlomiej to call but I'd certainly not be
opposed to freezing the security state in the kernel at boot by default.

Alan

