Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288746AbSADUJN>; Fri, 4 Jan 2002 15:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADUJF>; Fri, 4 Jan 2002 15:09:05 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:50829 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S284728AbSADUIy>; Fri, 4 Jan 2002 15:08:54 -0500
Message-ID: <3C360D22.F6FFFAD6@nortelnetworks.com>
Date: Fri, 04 Jan 2002 15:14:26 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel log messages using wrong timezone
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How does the kernel figure out how to timestamp the log output?  The reason I'm
asking is that we have a system that has /etc/localtime pointing to the
Americas/Montreal timezone, but the log output from the kernel appears to be
UTC.

Can anyone point me to the right place to deal with this?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
