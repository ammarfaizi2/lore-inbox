Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129493AbRBXIhy>; Sat, 24 Feb 2001 03:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129454AbRBXIho>; Sat, 24 Feb 2001 03:37:44 -0500
Received: from [202.123.212.187] ([202.123.212.187]:21512 "EHLO ns1.b2s.com")
	by vger.kernel.org with ESMTP id <S129489AbRBXIhb>;
	Sat, 24 Feb 2001 03:37:31 -0500
Message-ID: <3A9772DB.A51517B3@vtc.edu.hk>
Date: Sat, 24 Feb 2001 16:37:47 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel list <linux-kernel@vger.kernel.org>
Subject: Fwd: ip_tables problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, does anyone know what is going on here?  I am not sure what to suggest.

kammychoi wrote:

> when i type "modprobe ip_tables", it shows this:
>
> /lib/modules/2.4.1/kernel/net/ipv4/netfilter/ip_tables.o: unresolved symbol nf_unregister_sockopt
> /lib/modules/2.4.1/kernel/net/ipv4/netfilter/ip_tables.o: unresolved symbol nf_register_sockopt
> /lib/modules/2.4.1/kernel/net/ipv4/netfilter/ip_tables.o: insmod /lib/modules/2.4.1/kernel/net/ipv4/netfilter/ip_tables.o failed
> /lib/modules/2.4.1/kernel/net/ipv4/netfilter/ip_tables.o: insmod ip_tables failed
>
> what is the problem??
>
> pls help

--
Nick Urbanik, Dept. of Computing and Mathematics
Hong Kong Institute of Vocational Education (Tsing Yi)
email: nicku@vtc.edu.hk
Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2435 1406
pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B



