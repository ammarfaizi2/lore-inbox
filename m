Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVCMTRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVCMTRv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCMTRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:17:51 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:37279 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261424AbVCMTRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:17:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.11: keyboard stopped working after memory upgrade
Date: Sun, 13 Mar 2005 20:20:36 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200503121421.03983.rjw@sisk.pl> <20050313183635.GD1427@elf.ucw.cz>
In-Reply-To: <20050313183635.GD1427@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503132020.36968.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 13 of March 2005 19:36, Pavel Machek wrote:
> Hi!
> 
> > I'm just having a weird problem with 2.6.11.  Namely, the keyboard stopped
> > working after I'd added more RAM to the box (Asus L5D notebok, x86-64
> > kernel).  It works on 2.6.11-mm1.
> 
> Custom DSDT? DSDTs are known to depend on ammount of memory...

Yes, but the very same DSDT works fine on 2.6.11-mm[13].  Just for the record. :-)

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
