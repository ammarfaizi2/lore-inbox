Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVCCWYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVCCWYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVCCWVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:21:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34519 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262660AbVCCWR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:17:28 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109888144.21780.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Mar 2005 22:15:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-02 at 22:21, Linus Torvalds wrote:
>  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
>    to it (timeframe: a month or two).
>  - 2.<odd>.x: aim for big changes that may destabilize the kernel for 
>    several releases (timeframe: a year or two)
>  - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and rewrote
>    the kernel to be a microkernel using a special message-passing version 
>    of Visual Basic. (timeframe: "we expect that he will be released from 
>    the mental institution in a decade or two").

We still need 2.6.x.y updates on a more official footing and with more
than one person as the "2.6.x.y" maintainer. I think that is actually
more important.

The 2.6.<odd> thing is essentially irrelevant. You are just relabelling
pre
and rc to even and odd. It won't fool anyone into testing it more....

