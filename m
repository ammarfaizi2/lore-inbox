Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbRFZQ3G>; Tue, 26 Jun 2001 12:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265016AbRFZQ24>; Tue, 26 Jun 2001 12:28:56 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:40677 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265008AbRFZQ2m>; Tue, 26 Jun 2001 12:28:42 -0400
Message-ID: <3B38A97C.4010803@earthlink.net>
Date: Tue, 26 Jun 2001 11:25:48 -0400
From: Brad Chapman <kakadu@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i586; en-US; C-UPD: MaxLinux0301) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IPv6 fragmentation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

   I have asked this question before on this list and received no answer,
so I will try again.

   I am currently working on a port of the IPv4 connection tracking portion
of Netfilter/iptables to the IPv6 protocol. The port is almost complete, 
except
for fragment handling. I would appreciate a list of actions and 
functions required
to properly defragment and refragment IPv6 packets. I would also 
appreciate code
examples on how to properly parse the IPv6 header chain and return any 
one header,
based upon its code, found in /usr/src/linux/include/net/ipv6.h

Brad

