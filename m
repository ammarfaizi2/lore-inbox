Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278389AbRJMUOX>; Sat, 13 Oct 2001 16:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278394AbRJMUOQ>; Sat, 13 Oct 2001 16:14:16 -0400
Received: from james.kalifornia.com ([208.179.59.2]:29501 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S278389AbRJMUMM>; Sat, 13 Oct 2001 16:12:12 -0400
Message-ID: <3BC8A04A.5090108@blue-labs.org>
Date: Sat, 13 Oct 2001 16:12:58 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011010
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Tcpdump filters, problem with UDP and 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see a lot of "UDP: bad checksum. ..." between two of my servers.  I 
haven't attached a tcpdump output of the packets because a) the packets 
between machine A and B travel through a GRE tunnel and b) does anyone 
have tcpdump filters or know how to finagle tcpdump into dumping the 
embedded packet instead of the GRE header'd packet?

If not, I'll supply tcpdump output of the traffic.

David


