Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSDIJgk>; Tue, 9 Apr 2002 05:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313156AbSDIJgj>; Tue, 9 Apr 2002 05:36:39 -0400
Received: from [203.197.61.33] ([203.197.61.33]:21893 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313118AbSDIJgj>; Tue, 9 Apr 2002 05:36:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Vinolin <vinolin@nodeinfotech.com>
To: linux-kernel@vger.kernel.org
Subject: ip_route_input in arp_rcv
Date: Tue, 9 Apr 2002 15:06:42 +0530
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02040915064208.00884@Vinolin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

While i'm going through the arp.c code, 
found a checking "ip_route_input".
We can find out the address type whether it is "RTN_LOCAL" etc. by calling 
inet_addr_type itself. Why we need ip_route_input here.

Please clear my doubt.

Thanks in advance,
Vinolin.
