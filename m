Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266545AbUFQPoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUFQPoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUFQPod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:44:33 -0400
Received: from sanosuke.troilus.org ([66.92.173.88]:65167 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S266545AbUFQPoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:44:30 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: more files with licenses that aren't GPL-compatible
References: <200406180629.i5I6Ttn04674@freya.yggdrasil.com>
From: Michael Poole <mdpoole@troilus.org>
Date: Thu, 17 Jun 2004 11:44:29 -0400
In-Reply-To: <200406180629.i5I6Ttn04674@freya.yggdrasil.com> (Adam J.
 Richter's message of "Thu, 17 Jun 2004 23:29:55 -0700")
Message-ID: <87n032xk82.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter writes:

> 	I believe that distribution of Linux kernel binaries that
> compile in this firmware is direct copyright infringment, and
> that distribution of Linux kernel modules that compile in
> this firmware is contributory copyright infringement (to the direct
> infringmenet that occurs when the image is created in RAM, and
> there are US court cases that say that copying into RAM is copying
> for the purposes of copyright).
>
> 	The United States Copyright Office has issued a copyright
> registration to Yggdrasil Computing for some software in the Linux
> USB serial drivers.  Yggdrasil Computing has never given permission
> for distribution of GPL-incompatible firmware with that software.

The first "official" version of Linux that included USB serial code
that mentioned you (Adam Richter and/or Yggdrasil) was 2.4.  That same
version included the same binary firmware you complained about in
2001, and the changelog in usbserial.c makes it clear that *at least*
the WhiteHEAT firmware was already present when you contributed your
code.

Would you explain why your claim of copyright infringement is not
estopped by the pre-existing condition of firmware being present?

Michael Poole
