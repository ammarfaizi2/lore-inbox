Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRAVHey>; Mon, 22 Jan 2001 02:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRAVHee>; Mon, 22 Jan 2001 02:34:34 -0500
Received: from [213.221.172.237] ([213.221.172.237]:13072 "EHLO
	smtp-relay2.barrysworld.com") by vger.kernel.org with ESMTP
	id <S129881AbRAVHeY>; Mon, 22 Jan 2001 02:34:24 -0500
Date: Mon, 22 Jan 2001 07:33:43 +0000
From: Scaramanga <scaramanga@barrysworld.com>
To: linux-kernel@vger.kernel.org
Subject: Firewall netlink question...
Message-ID: <20010122073343.A3839@lemsip.lan>
Reply-To: scaramanga@barrysworld.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Under Linux 2.2.x I used to be able to use ipchains to send packet to a
netlink socket so that my userspace application could further analyze
the packet data.

Since kernel 2.4 and iptables, I have not enjoyed the same functionality,
has it been deprecated in favour of a better method, if so, what? I ask 
because I just spent my last few hours writing an iptables plugin, and 
netfilter target kernel module, in order to replace the old functionality 
exactly, to the end that my application works with zero modifications.

Have I missed something?

Kind regards

--
// Gianni Tedesco <scaramanga@barrysworld.com>
Fingerprint: FECC 237F B895 0379 62C4  B5A9 D83B E2B0 02F3 7A68
Key ID: 02F37A68

egg.microsoft.com: Remote operating system guess: Solaris 2.6 - 2.7

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
