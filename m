Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTKRXMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTKRXKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 18:10:36 -0500
Received: from dp.samba.org ([66.70.73.150]:57491 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263837AbTKRXKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 18:10:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modules.pnpmap output support 
In-reply-to: Your message of "Mon, 17 Nov 2003 15:37:25 +0300."
             <E1ALidB-000MWd-00.arvidjaar-mail-ru@f17.mail.ru> 
Date: Tue, 18 Nov 2003 14:07:09 +1100
Message-Id: <20031118231021.DEF372C24F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E1ALidB-000MWd-00.arvidjaar-mail-ru@f17.mail.ru> you write:
> 
> Oh, BTW, it reminds me - file2alias prints hex in upper
> case while both sysfs and hotplug present them in lower case
> (for sure for USB and PCI, and for PNP entries detected by 
> PNP BIOS). Should not we unify representation?

Sure.  I made it up.  Patch welcome.

Andrey Borzenkov for file2alias maintainer!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
