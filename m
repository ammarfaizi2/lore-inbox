Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbRBBV7x>; Fri, 2 Feb 2001 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129976AbRBBV7o>; Fri, 2 Feb 2001 16:59:44 -0500
Received: from h57s242a129n47.user.nortelnetworks.com ([47.129.242.57]:32476
	"EHLO zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129412AbRBBV7h>; Fri, 2 Feb 2001 16:59:37 -0500
Message-ID: <3A7B2B83.77548C64@nortelnetworks.com>
Date: Fri, 02 Feb 2001 16:49:55 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: question regarding routing/ethertap
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a quick question regarding the ethertap device and routing.  We're seeing
the contents of the packet coming up through the ethertap device just fine, but
the originating address seems to be overwritten with the ethertap device's
address.

Am I missing something obvious here?  I'm positive that this isn't how it's
supposed to work, but I don't know enough about the routing/forwarding stuff in
the kernel to know what I need to change.

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
