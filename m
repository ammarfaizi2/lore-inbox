Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUCQNoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 08:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUCQNoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 08:44:14 -0500
Received: from ddc.ilcddc.com ([12.35.229.4]:22291 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S261434AbUCQNoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 08:44:11 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B17006@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-kernel@vger.kernel.org
Cc: linux-newbie@vger.kernel.org
Subject: Arp Implementation Example....
Date: Wed, 17 Mar 2004 08:39:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All;

I am developed a network driver for my fibre channel device.  I've used the
O'Reilly Linux Device Driver's "snull.c and snull.h" as an
example.

Problem is this example does not implement ARP.  After many attempts, I
can't seem to pass an ARP packet successfully up
the stack......

Does anyone know of an example driver / website that shows the formatting
and responsibility of the network driver, with regards
to ARP?

Any help is much appreciated...

BTW, I'm using Linux 2.4....
 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

