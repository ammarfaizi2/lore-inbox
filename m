Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSHVQhT>; Thu, 22 Aug 2002 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHVQhT>; Thu, 22 Aug 2002 12:37:19 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45539 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S313563AbSHVQhS>; Thu, 22 Aug 2002 12:37:18 -0400
Message-ID: <3D65142F.116481FB@nortelnetworks.com>
Date: Thu, 22 Aug 2002 12:41:19 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: is kernel compilation supposed to change header file timestamps?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed the other day that on a kernel compile, the timestamps of some files are changed.  The
funny thing is that all the changed ones are header files, but not all header files are modified.

Is this expected behaviour?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
