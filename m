Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRAPGuB>; Tue, 16 Jan 2001 01:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRAPGtv>; Tue, 16 Jan 2001 01:49:51 -0500
Received: from iliganet-ipgi.iligan.com ([216.226.192.4]:21515 "HELO
	iliganet-ipgi.iligan.com") by vger.kernel.org with SMTP
	id <S129749AbRAPGts>; Tue, 16 Jan 2001 01:49:48 -0500
Date: Tue, 16 Jan 2001 14:48:40 +0800 (PHT)
From: rtviado <root@iligan.com>
To: <linux-kernel@vger.kernel.org>
Subject: ip_conntrack: maximum limit of 16368 entries exceeded
Message-ID: <Pine.LNX.4.30.0101161444450.24215-100000@bigbird-ipgi.iligan.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I got this in my logs:

 ip_conntrack: maximum limit of 16368 entries exceeded

what does this mean, I know i can change the limits in
/proc/sys/net/ipv4/ip_conntrack_max, but I want to know what this is for.

P.S. I looked into linux/Documentation but did not find any mention of
this configrable parameter....


-- 
Rodel T. Viado
System Administrator
Iligan Global Access Network Inc.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
