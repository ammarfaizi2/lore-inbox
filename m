Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286508AbRLUB3r>; Thu, 20 Dec 2001 20:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286510AbRLUB3h>; Thu, 20 Dec 2001 20:29:37 -0500
Received: from svr3.applink.net ([206.50.88.3]:42759 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S286508AbRLUB3f>;
	Thu, 20 Dec 2001 20:29:35 -0500
Message-Id: <200112210129.fBL1TPSr018455@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Fwd: Re: Intel Kennereth LAN Support (Found)
Date: Thu, 20 Dec 2001 19:25:44 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 20 December 2001 12:55, Timothy Covell wrote:
> I've got a couple computers with built-in Intel
> Kennereth LAN connections ( i815E chipset).
> RH7.2 supports this with a custom patch which
> I've been able to apply to later kernels by hand,
> but it sure is a pain in the butt.  Are there any plans
> for a fully free driver?

Oops, my fault, it looks like it's been rolled into
the eepro100 driver.   Pretty sneaky that.
I've got 2.4.16 working w/o any extra work.

-- 
timothy.covell@ashavan.org.
