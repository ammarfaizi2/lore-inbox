Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRGONMo>; Sun, 15 Jul 2001 09:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266448AbRGONMe>; Sun, 15 Jul 2001 09:12:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7442 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266438AbRGONMT>; Sun, 15 Jul 2001 09:12:19 -0400
Subject: Re: Linux 2.4.6-ac3
To: gareth.hughes@acm.org (Gareth Hughes)
Date: Sun, 15 Jul 2001 14:12:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B50F5B0.7058B30A@acm.org> from "Gareth Hughes" at Jul 15, 2001 11:45:20 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Llhc-0003zS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fair enough.  However, we now no longer have the same core DRM functions
> copied-and-pasted into each individual driver, renamed to foo_* and
> tweaked to add AGP support.  If something needs fixing in the core DRM
> stuff, it can be done in one place now, and all drivers will see the
> fix.
> 
> Oh, and at least the new MGA driver is stable.

Excellent.

DRM 4.1 is something that needs discussion rather than being ignored. I sort
of expect it to look like XFree code anyway and I can see bits of the macro
stuff will really help with the *BSD code

