Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267687AbUHPQQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbUHPQQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHPQQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:16:48 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:63684 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S267687AbUHPQQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:16:35 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200408161616.SAA05784@cleopatra.math.tu-berlin.de>
Subject: Re: netmos patches
In-Reply-To: <20040815185328.57717f72.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 16 Aug 2004 18:16:27 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

> > The following is a patch against
> >  2.6.8-rc4 to add support for all NetMOS devices I could get hold of:
> 
> This doesn't work any better than the previous one?
> 
> drivers/parport/parport_pc.c:2677: redefinition of `netmos_9705'
> drivers/parport/parport_pc.c:2666: `netmos_9705' previously defined here

No, that's in fact identical. Might not have been in the kernel revision
I had for testing, so please just throw out the duplicates, sorry.

So long,
	Thomas


