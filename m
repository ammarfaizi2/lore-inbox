Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130910AbRBVVs0>; Thu, 22 Feb 2001 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRBVVsQ>; Thu, 22 Feb 2001 16:48:16 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:12409 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S130910AbRBVVsB>; Thu, 22 Feb 2001 16:48:01 -0500
Date: Thu, 22 Feb 2001 22:48:19 +0100
Message-Id: <200102222148.f1MLmJr02802@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.2 & IPv6
In-Reply-To: <007101c09ce4$39dc7680$b323ce88@eeng.dcu.ie>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.2 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <007101c09ce4$39dc7680$b323ce88@eeng.dcu.ie> you wrote:
> Linux-2.4.2 does not have IPv6 support ???

[root@lt /root]# ping6 3ffe:8010:19::2:2
PING 3ffe:8010:19::2:2(3ffe:8010:19::2:2) from ::1 : 56 data bytes
64 bytes from 3ffe:8010:19::2:2: icmp_seq=0 hops=64 time=84 usec
64 bytes from 3ffe:8010:19::2:2: icmp_seq=1 hops=64 time=64 usec

[root@lt /root]# uname -r
2.4.2


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
