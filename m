Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbULJCbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbULJCbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 21:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULJCbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 21:31:23 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:35836 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261652AbULJCbU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 21:31:20 -0500
Date: Thu, 09 Dec 2004 21:31:01 -0500
From: Les Schaffer <schaffer@optonline.net>
Subject: Re: usb does not work on via's smp mainboard
To: linux-kernel@vger.kernel.org
Message-id: <200412092131.01480.schaffer@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:


> 
> Can you try a newer, 2.4 or even 2.6 kernel?  This is probably an
> interrupt routing issue that should be fixed in a newer kernel.

i've had the same problem even with 2.6.9. i saw your note from a couple
years ago saying you thought the via board was broken in this regard
(unconnected pin or something). and i wondered, but how come it works in
windows w/ SMP then? 

anyway, i also am ok with noapic, tho i wonder what performance losses there
are when an SMP system cant handle interrupts assigned to either proc.

hey, i'd even be willing to try some soldering or board changes if you had a
sense of what was disconnected. but are you sure its not a kernel issue?

thanks

les schaffer
