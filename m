Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWFLKBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWFLKBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWFLKBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:01:34 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:45468 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751684AbWFLKBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:01:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Meelis Roos <mroos@linux.ee>
Subject: Re: PS/2 vs IDE problem on Athlon64 X2
Date: Mon, 12 Jun 2006 12:01:57 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060612074437.0690014018@rhn.tartu-labor>
In-Reply-To: <20060612074437.0690014018@rhn.tartu-labor>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121201.57708.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 09:44, Meelis Roos wrote:
> RJW> I have a machnine with Athlon64 X2 and AsRock 939Dual-SATA2 mobo (based
> RJW> on the ULI chipset) on which the PS/2 devices (keyboard and mouse) are in a
> RJW> bad correlation with IDE, or at least with the LiteOn DVD burner attached to it.
> 
> I recently got the same mainboard and it works fine for me with CD
> reading/writing (LG CDRW, no DVD drive). Just tried yesterday, wrote a
> CD at speed 12 and then read it as fast as it could and I did not notice
> anything wrong. I'm using PS/2 keyboard and mouse and a very recent git
> kernel (2.6.17-rc6+...). Maybe the CD speed is not enough to trigger it.

That would probably mean there's a hardware problem with my mobo.  Well ...

> Are you sure DMA was on?

Yes.

Greetings,
Rafael
