Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312638AbSCZSCX>; Tue, 26 Mar 2002 13:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312643AbSCZSCN>; Tue, 26 Mar 2002 13:02:13 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:6375 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S312638AbSCZSB6>; Tue, 26 Mar 2002 13:01:58 -0500
Message-ID: <3CA0B9AB.F96B83EE@nortelnetworks.com>
Date: Tue, 26 Mar 2002 13:10:51 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: is iproute2-2.4.7-now-ss020116-try safe to use?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're moving a linux-based project from the 2.2 kernel to 2.4, and one of the
components is based on iproute2 (yes, the source is distributed as required).

Anyways, after trying some recent versions of iproute2, the only one that
compiles cleanly out of the box is iproute2-2.4.7-now-ss020116-try.  The "try"
makes me a bit nervous, so I was wondering if there are any known issues with
this version.

Anyone know?  Alexey?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
