Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUGAP0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUGAP0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUGAP03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:26:29 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:54427 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265897AbUGAP01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:26:27 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Linux-usb-users] linux 2.6.6, bttv and usb2 data corruption & lockups & poor performance
Date: Thu, 1 Jul 2004 17:26:24 +0200
User-Agent: KMail/1.6.2
Cc: linux-usb-users@lists.sourceforge.net, janne <sniff@xxx.ath.cx>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0407011107270.1083-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0407011107270.1083-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011726.24592.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > I get hard hangs with a Bt878 + disk activity (every time it hangs,
> > the disk activity LED is on).  But I don't have usb2.  However I have
> > a similar processor, Athlon XP 2100+, and motherboard, VIA KT333.
> > I'm also using reiserfs (where an OOPS occurred in your system logs).
> > I also have a realtek 8139 ethernet card.  We both have VIA usb 1.1
> > controllers.  My hangs happen with both 2.4 and 2.6 kernels.  I only
> > get hangs if I'm using the bttv card.
> 
> Is it possible that you are exceeding the capacity of your PCI bus?

I guess so, but that's no reason to hang...  Or is overloading the PCI
bus somehow problematic?

Ciao,

Duncan.
