Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTKTAqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 19:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTKTAqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 19:46:17 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:3046 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S261176AbTKTAqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 19:46:15 -0500
Message-ID: <1069289154.3fbc0ec2a9b6e@horde.sandall.us>
Date: Wed, 19 Nov 2003 16:45:54 -0800
From: Eric Sandall <eric@sandall.us>
To: Valdis.Kletnieks@vt.edu
Cc: Wilmer van der Gaast <lintux@lintux.cx>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Configuration help texts for IPsec 
References: <20031115150841.GA4854@gaast.net> <Xine.LNX.4.44.0311170948100.1445-100000@thoron.boston.redhat.com>            <20031117145723.GB1268@gaast.net> <200311171507.hAHF7INt007210@turing-police.cc.vt.edu>
In-Reply-To: <200311171507.hAHF7INt007210@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Valdis.Kletnieks@vt.edu:
> On Mon, 17 Nov 2003 15:57:23 +0100, Wilmer van der Gaast said:
> 
> > Shouldn't the text "If unsure, say Y." be more like "If you want to use
> > IPsec, you need this."? Possibly with an addition like "If you don't
> > know what IPsec is, you don't need it."?
> 
> A lot of people don't have the foggiest idea what IPsec is, but do
> know they're trying to use a VPN.  Probably need to include that in there,
> if you're trying to do anything with the help text.

Agreed with both of the above, as many people don't need IPsec, so why should
they be incouraged (or rather, told to use) IPsec (note that the knowledgable
ones will probably know that they /don't/ need it, and so remove it, but that's
my point ;)).

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
