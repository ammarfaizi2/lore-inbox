Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWJEVFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWJEVFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWJEVFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:05:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47261 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751354AbWJEVFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:05:04 -0400
Subject: Re: to many sockets ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Wenke <M.Wenke@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4524B0E9.8010005@web.de>
References: <4523CD4E.10806@web.de>
	 <1159979587.25772.82.camel@localhost.localdomain> <4524B0E9.8010005@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 22:30:51 +0100
Message-Id: <1160083851.1607.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 09:14 +0200, ysgrifennodd Markus Wenke:
> and the oom-killer kills my application at the same time (at 140000 
> connections).
> 
> I can not see in the messages that the system is out of memory,
> there is also no swap space used
> 
> You can download my /var/log/messages at 
> http://hemaho.mine.nu/~biber/messages
> 
> May you can give me a hint which line/value in the log shows me,
> that the system is out of memory?

That sounds like a bug. What kernel are you using ?


