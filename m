Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312882AbSDBRn6>; Tue, 2 Apr 2002 12:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312872AbSDBRns>; Tue, 2 Apr 2002 12:43:48 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:34707 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S312867AbSDBRnd>; Tue, 2 Apr 2002 12:43:33 -0500
Message-ID: <3CA9F019.E388F489@nortelnetworks.com>
Date: Tue, 02 Apr 2002 12:53:29 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: any problems with gcc 3.0/3.1 and compiling 2.4.18 on ppc?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're looking at moving to gcc 3.x for 2.4.18, and are trying to decide what
version to use.  It appears that there were some ppc-specific fixes that went in
to 3.1, and I'm not sure if they were ported back to 3.0.

Has anyone had any successes or failures using either of these versions on ppc? 
Any gotchas?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
