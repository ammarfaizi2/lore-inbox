Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTFYUtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbTFYUtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:49:17 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:10199 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id S265061AbTFYUtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:49:16 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
To: Michael Bellion and Thomas Heinz <nf@hipac.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
Date: Wed, 25 Jun 2003 23:03:13 +0200
User-Agent: KMail/1.5.2
References: <200306252248.44224.nf@hipac.org>
In-Reply-To: <200306252248.44224.nf@hipac.org>
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306252303.13366.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> nf-hipac is a drop-in replacement for the iptables packet filtering module.
> It implements a novel framework for packet classification which uses an
> advanced algorithm to reduce the number of memory lookups per packet.
> The module is ideal for environments where large rulesets and/or high
> bandwidth networks are involved. Its userspace tool, which is also called
> 'nf-hipac', is designed to be as compatible as possible to 'iptables -t
> filter'.

Looks great!
Any chance on a port to 2.5.x?


Greetings,

Folkert van Heusden

+-> www.vanheusden.com       folkert@vanheusden.com       +31-6-41278122 <-+
+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+--------------------------------------------------------------------------+

