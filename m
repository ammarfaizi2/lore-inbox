Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRDEAaC>; Wed, 4 Apr 2001 20:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRDEA3o>; Wed, 4 Apr 2001 20:29:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9233 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130487AbRDEA3l>; Wed, 4 Apr 2001 20:29:41 -0400
Subject: Re: MPEG-2 decoding driver for Trident Cyberblade i7
To: mshiloh@mediabolic.com (Michael Shiloh)
Date: Thu, 5 Apr 2001 01:31:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104041710540.943-100000@michael.channeldot.com> from "Michael Shiloh" at Apr 04, 2001 05:15:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kxgR-00035x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Searching on the web, I see a few question but no answers
> to the question of whether a driver exists that can utilize
> the MPEG-2 hardware assist feature of the Trident
> Cyberblade i7.
> 
> Any pointers?

That would be part of the XFree 4 server if supported on that card yet. The
hardware scalers/YUV for several cards are supported by XFree 4.0 and the
xv extension. Players such as xine wil use that if present. 

So its an XFree question..
