Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbRBMVWs>; Tue, 13 Feb 2001 16:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbRBMVWh>; Tue, 13 Feb 2001 16:22:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55563 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130488AbRBMVWV>; Tue, 13 Feb 2001 16:22:21 -0500
Subject: Re: 2.2.19pre10 locks up hard on unloading the isdn module 'hisax.o' - 2.2.19pre11 does too!
To: thunder7@xs4all.nl
Date: Tue, 13 Feb 2001 21:22:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, keil@isdn4linux.de
In-Reply-To: <20010213221759.A718@middle.of.nowhere> from "thunder7@xs4all.nl" at Feb 13, 2001 10:17:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SmuA-0002vY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's Linux, after all, so 2 minutes after creating this email
> 2.2.19pre11's announcement was here. I just tested it, and it has the
> same problem.

Yep. Right now Im still working through the merges with Kai and I suspect
the merge when completed may not fix your bug, but that it'll get squashed
shortly after.
