Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTEFMIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTEFMIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:08:39 -0400
Received: from [203.94.130.164] ([203.94.130.164]:56528 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S262627AbTEFMIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:08:31 -0400
Date: Tue, 6 May 2003 22:00:12 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: Wichert Akkerman <wichert@wiggy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 just doesn't boot (neither does anything > .67)
In-Reply-To: <20030506120608.GF20419@wiggy.net>
Message-ID: <Pine.LNX.4.44.0305062156070.1962-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As I said in the previous time I reported this

p75 toshiba satellite laptop
grub-0.92
(0.93 fails to compile, reported to grub savannah page, and have heard 
nothing back from)

Linux lapsis 2.5.67 #3 Wed Apr 16 22:38:53 EST 2003 i586 unknown

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.11a
e2fsprogs              1.32
reiserfsprogs          3.x.0j
pcmcia-cs              3.2.0
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0j
Modules Loaded         ppp_deflate zlib_deflate zlib_inflate bsd_comp 
ppp_async ppp_generic slhc ipt_MASQUERADE iptable_mangle iptable_nat 
ipt_REJECT ipt_limit ipt_state ip_conntrack ipt_LOG ipt_ULOG 
iptable_filter ip_tables 8250_cs xirc2ps_cs

thanks,

	/ Brett

On Tue, 6 May 2003, Wichert Akkerman wrote:

> Previously Brett wrote:
> > please, can't someone give me a hand here ??
> 
> How about providing some possibly useful information such as grub
> version, machine type, etc.
> 
> Wichert.
> 
> 

