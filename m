Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSEXU7q>; Fri, 24 May 2002 16:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSEXU7p>; Fri, 24 May 2002 16:59:45 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:9213 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S293203AbSEXU7p>; Fri, 24 May 2002 16:59:45 -0400
Message-ID: <3CEEA9BA.AAFED19F@nortelnetworks.com>
Date: Fri, 24 May 2002 16:59:38 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to get per-socket stats on udp rx buffer overflow?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted this on netdev, but got no answer.

Is there any way for me to see how many incoming packets were dropped on a udp
socket due to overflowing the input buffer?  I specifically want this
information on a per-socket basis.

Thanks,

Chris
-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
