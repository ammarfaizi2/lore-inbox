Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTFIMoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 08:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTFIMoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 08:44:17 -0400
Received: from [209.167.240.9] ([209.167.240.9]:53757 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id S264226AbTFIMoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 08:44:14 -0400
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : TCPA updates
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: Martin List-Petersen <martin@list-petersen.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1054940371.3044.40.camel@loke>
References: <1054940371.3044.40.camel@loke>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Jun 2003 08:57:52 -0400
Message-Id: <1055163473.25882.13.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 18:59, Martin List-Petersen wrote:
> Eerh, dumb question here: Is this MiniPCI Wlan cards in general or how ?
> I ask, because i've seen MiniPCI Wlan cards and i've seen cards that in
> fact are PC-Card Wlan cards and a PC-Card-to-PCI bridge put together on
> a MiniPCI card, just adding another PC-Card slot to your notebook and
> inserting a Wlan card there (Dell TrueMobile 1150).

IIRC, it's the antenna PLUS the WLan card that gets FCC licensed,
so you violate FCC rules by allowing a card without an antenna,
and this is why even 'regular' pcmcia cards all have their own
'unique' antenna jacks, so you can't plug in an off the shelf antenna
and boost your signal.

So the theory that the IBM laptops with built in antennas can't
use just any mini-PCI card makes sense, even if it is stupid.
They would have been licensed for specific cards only, and would
be violating the FCC license to use other cards.

I hope that's all it is.  If they had some other reason I'd be very
pissed off if I bought a stinkpad.  (Wait a minute, I did buy a
stinkpad :)

Dana Lacoste
Ottawa, Canada

