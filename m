Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVCBXNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVCBXNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVCBXJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:09:07 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:26093 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261311AbVCBXGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:06:43 -0500
Subject: Re: RFD: Kernel release numbering
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1109804917.3711.5.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 03 Mar 2005 10:08:37 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

My first response is: this is a recipe for great confusion among users.

I'd far rather see things only make it into your tree when they've been
thoroughly tested (in -mm and prior to that). Following that strategy,
your tree could always be relied upon to be stable and -rcs would only
needed for dealing with the unforeseen interactions between otherwise
mature patches.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


