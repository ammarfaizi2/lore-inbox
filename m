Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277986AbRJRTNv>; Thu, 18 Oct 2001 15:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278001AbRJRTNm>; Thu, 18 Oct 2001 15:13:42 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:51642 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S277986AbRJRTN1>; Thu, 18 Oct 2001 15:13:27 -0400
Message-ID: <3BCF2A44.60B295FD@nortelnetworks.com>
Date: Thu, 18 Oct 2001 15:15:16 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru
Subject: how to see manually specified proxy arp entries using "ip neigh" 
         command?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I (and others) have asked this a couple times here and on the netdev list, and
so far nobody has answered it (not even negatively).

If I manually set some proxy arp entries and then list the arp entries, the
manually set ones do not show up when using "ip neigh" but they do show up with
the "arp" command.

Is there any way to see them using "ip neigh"?  If not, are there any plans to
enable this?

If not, I may have to look at adding support for this, and this is why I'm
wondering.

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
