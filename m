Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTDGLT3 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbTDGLT3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:19:29 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:60328 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S263375AbTDGLT2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 07:19:28 -0400
Date: Mon, 7 Apr 2003 13:26:55 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Mark Syms <mark@marksyms.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine dirve in 2.4.21-pre7
Message-ID: <20030407112655.GA24753@k3.hellgate.ch>
Mail-Followup-To: Mark Syms <mark@marksyms.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <1049706637.963.6.camel@athlon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049706637.963.6.camel@athlon>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.65 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Apr 2003 10:10:37 +0100, Mark Syms wrote:
> Just tried the via-rhine driver in 2.4.21-pre7 and it appears to exhibit
> the problem Erik Hensema reported with the VT6103 onboard network card
> on my Chaintech 7VJL Athlon board whereby you get NETDEV Watchdog
> transmit timeout errors unless you turn local io-apic off in which case
> it all works fine.

How did previous versions fare?

