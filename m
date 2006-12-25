Return-Path: <linux-kernel-owner+w=401wt.eu-S1754573AbWLYXXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbWLYXXf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 18:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbWLYXXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 18:23:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:35979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754573AbWLYXXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 18:23:34 -0500
X-Authenticated: #20450766
Date: Tue, 26 Dec 2006 00:23:38 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mark Glines <mark@glines.org>
cc: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  powerpc: linkstation uses uimage style zImages
In-Reply-To: <45905997.5080403@glines.org>
Message-ID: <Pine.LNX.4.60.0612260019430.3424@poirot.grange>
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
 <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no> <45902A6F.4000100@glines.org>
 <Pine.LNX.4.60.0612252128530.3424@poirot.grange> <459046FE.9030008@glines.org>
 <Pine.LNX.4.60.0612252349040.3424@poirot.grange> <45905997.5080403@glines.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2006, Mark Glines wrote:

> Guennadi Liakhovetski wrote:
> 
> Yes, I do very much intend to test it on real hardware.  I have a couple of
> Kurobox HGs which desperately need a 21st century kernel.  I still need to

Ah, what a pity:-) I mean, it is good, but it's exactly the same hardware 
I developed this port for and tested on. So, it should be easy. If you 
have any problems with your setup, look in linkstation / kurobox mailing 
list archives, I posted some instructions there for setting up a suitable 
u-boot version. Or just ask me. Or I could even just send you binaries to 
start with. Do you have JTag?...

Thanks
Guennadi
---
Guennadi Liakhovetski
