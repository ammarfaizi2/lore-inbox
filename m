Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbUKGVsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUKGVsl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUKGVsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:48:41 -0500
Received: from compunauta.com ([69.36.170.169]:12449 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S261691AbUKGVsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:48:38 -0500
From: Gustavo Guillermo Perez <gustavo@compunauta.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with USB 1.1 Storage plugged in USB 2.0
Date: Mon, 8 Nov 2004 11:49:12 +0600
User-Agent: KMail/1.5.4
References: <1099846698.6045.7.camel@localhost>
In-Reply-To: <1099846698.6045.7.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411081149.12209.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Domingo 07 Noviembre 2004 22:58, Jean-Yves LENHOF escribió:

> I just enter this bug because I want to buy a new laptop and very often
> there's only USB 2.0 port on new ones...
>
> Quickly my problem :
> I try to mount as a usb-storage my Minolta DiMAGE F200 (which seems to
> be USB
> 1.1)  on a kernel 2.6
>
> If I plug it on a USB 2.0 plug, it hangs
> If I plug it on a USB 1.1 plug, it works
Reproductable, I have an Adaptor for SecureDigital Cards to download images 
from a cammera, And only works in USB 1.1 plug, Kernel is 2.6.6 and 2.6.7.
Cause I not own the adaptor, I don't have a chance to try without ehci enabled 
(rmmod ehci-hcd).
-- 
-------
Gustavo Guillermo Perez
Compunauta uLinux
www.userver.tk

