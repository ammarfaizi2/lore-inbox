Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTJQRxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTJQRxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:53:55 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:30408 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S263488AbTJQRxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:53:53 -0400
Message-ID: <1066413232.3f902cb07906e@horde.sandall.us>
Date: Fri, 17 Oct 2003 10:53:52 -0700
From: Eric Sandall <eric@sandall.us>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017013245.GA6053@ncsu.edu> <1066355235.3f8f4a2395fa0@horde.sandall.us> <200310170811.h9H8BMpV000171@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200310170811.h9H8BMpV000171@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 134.121.40.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Bradford <john@grabjohn.com>:
> Comparing the reliability of the hash function to the reliability of
> hardware is an apples to oranges comparison.  Far more interesting
> would be to compare the correlation between reliability of each of
> them to the input data.
<snip> 
> John.

Very true, but I wasn't trying to compare them, instead I was saying (or trying
to say) that we don't want an /extra/ layer of possible corruption, if it can
be avoided.

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
