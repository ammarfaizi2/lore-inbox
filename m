Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUGVJiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUGVJiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266848AbUGVJiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:38:24 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:56497 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266845AbUGVJ0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:26:52 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F43052@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'bert hubert'" <ahu@ds9a.nl>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: crossgcc <crossgcc@sources.redhat.com>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: (somewhat questionable) use of ipt_ECN.c and ipt_ecn.c in the
	 linux kernel
Date: Thu, 22 Jul 2004 05:25:51 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is the (somewhat questionable) use of ipt_ECN.c and ipt_ecn.c in the
linux kernel.

I presume that "Cygwin" folks would like to see this to be resolved by the
"linux kernel" folks ?

-----Original Message-----
From: bert hubert [mailto:ahu@ds9a.nl]
Sent: Thursday, July 22, 2004 5:03 AM
To: Povolotsky, Alexander
Cc: crossgcc; 'Hollis Blanchard'; 'bertrand marquis';
'trevor_scroggins@hotmail.com'; 'Dan Kegel'; 'Geert Uytterhoeven';
'linuxppc-dev@lists.linuxppc.org'; Linux Kernel list
Subject: Re: No rule to make target `net/ipv4/netfilter/ipt_ecn.o'


> make[3]: *** No rule to make target
>  `net/ipv4/netfilter/ipt_ecn.o', needed by
`net/ipv4/netfilter/built-in.o'.
> Stop.

This is the (somewhat questionable) use of ipt_ECN.c and ipt_ecn.c in the
linux kernel. Windows filesystems are case insensitive, and see this as one
file.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
