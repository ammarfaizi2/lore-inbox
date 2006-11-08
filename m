Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754484AbWKHJnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbWKHJnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbWKHJnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:43:43 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:10713 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1754484AbWKHJnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:43:42 -0500
Subject: Re: Linux 2.6.19-rc5
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 20:43:38 +1100
Message-Id: <1162979018.12585.0.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday.

On Tue, 2006-11-07 at 18:33 -0800, Linus Torvalds wrote:
> Ok, things are finally calming down, it seems.
> 
> The -rc5 thing is mainly a few random architecture updates (arm, mips, 
> uml, avr, power) and the only really noticeable one there is likely some 
> fixes to the local APIC accesses on x86, which apparently fixes a few 
> machines.
> 
> The rest is really mostly one-liners (or close) to various subsystems. New 
> PCI ID's, trivial fixes, cifs, dvb, things like that. I'm feeling better 
> about this - there may be a -rc6, but maybe we don't even need one.
> 
> As usual, thanks to everybody who tested and chased down some of the 
> regressions,
> 
> 		Linus

The patch etc doesn't seem to be available yet. (The front page is still
showing -rc4, for example).

Regards,

Nigel

