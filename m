Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUHHQ1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUHHQ1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUHHQ1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:27:10 -0400
Received: from the-village.bc.nu ([81.2.110.252]:53446 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265847AbUHHQ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:27:02 -0400
Subject: Re: ide-cs using 100% CPU
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hamie <hamish@travellingkiwi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4115EC6C.5040608@travellingkiwi.com>
References: <40FA4328.4060304@travellingkiwi.com>
	 <20040806202747.H13948@flint.arm.linux.org.uk>
	 <4113DD20.1010808@travellingkiwi.com>
	 <1091917597.19077.38.camel@localhost.localdomain>
	 <4115EC6C.5040608@travellingkiwi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091978671.12048.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 08 Aug 2004 16:24:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hdparm -u1 /dev/hd[whatever]

will help a lot on the sluggishness

