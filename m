Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263295AbTC0Qv5>; Thu, 27 Mar 2003 11:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263297AbTC0Qv5>; Thu, 27 Mar 2003 11:51:57 -0500
Received: from [81.2.110.254] ([81.2.110.254]:53494 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263295AbTC0Qv4>;
	Thu, 27 Mar 2003 11:51:56 -0500
Subject: Re: Kernel Itself Reports Bug, Continuous OOPS's, and Phantom NIC
	Card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Voigt <adam@cryptocomm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048776183.1873.2.camel@beowulf.cryptocomm.com>
References: <1048776183.1873.2.camel@beowulf.cryptocomm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048784675.3228.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 17:04:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 14:42, Adam Voigt wrote:
> Behavior with the OOPS's, is sporatic, I can turn the machine
> on, wait ten minutes, and log in, and do a "ls" and it will
> OOPS, other times it will be hours before I see them.

Does it pass things like memtest86

> One other problem, probably unrelated, the BIOS and the Kernel
> both report seeing a "Realtek 8139" NIC on the computer, though
> no such card exists and it is not built onto the mobo, only a
> 3COM 3c59x (PCI Card).

If its seen it will be there somewhere. It may just be integrated
into something and not actually used by the vendor.

