Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVCMXpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVCMXpo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 18:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCMXpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 18:45:44 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:23205 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261589AbVCMXpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 18:45:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11: keyboard stopped working after memory upgrade
Date: Mon, 14 Mar 2005 00:48:28 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>
References: <200503121421.03983.rjw@sisk.pl> <20050313183635.GD1427@elf.ucw.cz> <200503132020.36968.rjw@sisk.pl>
In-Reply-To: <200503132020.36968.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140048.29115.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 13 of March 2005 20:20, Rafael J. Wysocki wrote: 
> On Sunday, 13 of March 2005 19:36, Pavel Machek wrote:
> > Hi!
> > 
> > > I'm just having a weird problem with 2.6.11.  Namely, the keyboard stopped
> > > working after I'd added more RAM to the box (Asus L5D notebok, x86-64
> > > kernel).  It works on 2.6.11-mm1.
> > 
> > Custom DSDT? DSDTs are known to depend on ammount of memory...
> 
> Yes, but the very same DSDT works fine on 2.6.11-mm[13].  Just for the record. :-)

Evidently, without the custom DSDT the keyboard works fine on 2.6.11 too.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
