Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTAWTMZ>; Thu, 23 Jan 2003 14:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTAWTMZ>; Thu, 23 Jan 2003 14:12:25 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:51075 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261290AbTAWTMY>; Thu, 23 Jan 2003 14:12:24 -0500
Message-ID: <3E3040B7.6040001@nortelnetworks.com>
Date: Thu, 23 Jan 2003 14:21:27 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: is it possible to bridge virtual devices (ie. a GRE tunnel)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want to set up two physically separate LANs with the same network 
address and logically bridge them using some kind of tunnel over an IP 
network.

I was hoping to somehow combine bridging with GRE tunnels in the kernel 
to accomplish this, but I haven't been able to find out for sure if the 
current kernel bridging code can handle a tunnel device as one of the 
bridge elements.

Can anyone give the definitive answer for this?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

