Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVDKQEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVDKQEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVDKQCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:02:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:47002 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261804AbVDKQBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:01:18 -0400
X-Authenticated: #222435
From: Jonas Diemer <diemer@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: security issue: hard disk lock
Date: Mon, 11 Apr 2005 18:01:16 +0200
User-Agent: KMail/1.8
References: <200504041942.10976.diemer@gmx.de> <1113233800.9875.47.camel@localhost.localdomain>
In-Reply-To: <1113233800.9875.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111801.16647.diemer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

Thanks for the info

Am Montag 11. April 2005 17:36 schrieb Alan Cox:
> It makes little difference as the attacker can replace the kernel and
> reboot.
> Anyway they can flash erase your video card bios, your IDE firmware,
> your BIOS
> and far more just as easily.

Yes, but a new video-card or Motherboard can be easily bought (although it 
costs), but the data on a locked disk is lost forever, unless you pay for 
professional recovery (which is also a time-issue, if time critical data is 
stored on the disk). Of course, this can be solved with a good backup 
strategy...

I agree with you though, that this really isn't a kernel issue, but a BIOS 
thing. Distributors should/could provide additional security by freezing the 
security-features early during boot, until BIOS vendors do their homework.

regards,
Jonas

PS: Still not on the list, so please CC me in an eventual reply.
