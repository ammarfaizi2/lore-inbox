Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTLKJWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbTLKJWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:22:37 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:29197 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S264830AbTLKJWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:22:35 -0500
Date: Thu, 11 Dec 2003 10:22:31 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.0-test11: PCMCIA] i82365: No such device...
In-Reply-To: <20031211091707.A23722@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0312111021230.1130-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Russell King wrote:

> On Thu, Dec 11, 2003 at 09:37:38AM +0100, Guennadi Liakhovetski wrote:
> > 00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
>           ^^^^^^^^^^^^^^
>
> Cardbus is 32-bit, so you need to use yenta not i82365.

Ok, thanks, will try. I knew that in general, was just confused by the
fact, that it worked under 2.4 and that it says "16bit CardBus" in BIOS...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

