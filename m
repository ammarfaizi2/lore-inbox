Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSHBRHU>; Fri, 2 Aug 2002 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSHBRHU>; Fri, 2 Aug 2002 13:07:20 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:48083 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315267AbSHBRHT>; Fri, 2 Aug 2002 13:07:19 -0400
Message-ID: <3D4ABD12.BBAA0646@nortelnetworks.com>
Date: Fri, 02 Aug 2002 13:10:42 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about CONFIG_IP_ACCEPT_UNSOLICITED_ARP 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking at the arp code and noticed the CONFIG_IP_ACCEPT_UNSOLICITED_ARP
option.

I'm a bit confused, however, since there is no way to enable this option without
specifying it on the command line.  Is this by intent?  It seems to have been
added back in 1998 in a patch by Thomas Koenig.

Just curious,

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
