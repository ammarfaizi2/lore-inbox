Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUITBAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUITBAC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 21:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUITBAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 21:00:02 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:49637 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265222AbUITA76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:59:58 -0400
From: David Sanders <linux@sandersweb.net>
To: jonathan@jonmasters.org
Subject: Re: Kernel Panic, Fedora Core 2, Virtual PC
Date: Sun, 19 Sep 2004 21:00:00 -0400
User-Agent: KMail/1.7
References: <200409191707.04177.linux@sandersweb.net> <35fb2e590409191725123e9222@mail.gmail.com>
In-Reply-To: <35fb2e590409191725123e9222@mail.gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409192100.00656.linux@sandersweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 September 2004 20:25, Jon Masters wrote:
> On Sun, 19 Sep 2004 17:07:03 -0400, David Sanders <linux@sandersweb.net> 
wrote:
> > Trying to install Fedora Core 2 on Virtual PC (using Dell Dimension 4600
> > with 2.8 GHz with HT, 1 GB or RAM.) it crashes right after typing 'linux
> > text'.
>
> Which processor model is it emulating?
>
> Jon.
I don't think it emulates a processor per say (this is the PC version).  Most 
of the hardware is emulated but the processor is just bridged.  So within a 
guest operating system you would detect your actual processor not an emulated 
processor (unless you have two processors or HT, in which case you see only 
one).
-- 
David Sanders
