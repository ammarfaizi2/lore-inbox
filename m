Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTEHV7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTEHV7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:59:46 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:54734 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262160AbTEHV7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:59:43 -0400
Message-ID: <3EBAD63C.4070808@nortelnetworks.com>
Date: Thu, 08 May 2003 18:12:12 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to test the scheduler latency on a powerpc platform.  It appears that 
a realfeel type of program won't work since you can't program /dev/rtc to 
generated interrupts on powerpc.  Is there anything similar which could be done?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


