Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQL2PoS>; Fri, 29 Dec 2000 10:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQL2PoJ>; Fri, 29 Dec 2000 10:44:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25509 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129226AbQL2Pn7>;
	Fri, 29 Dec 2000 10:43:59 -0500
From: tom_gall@vnet.ibm.com
Message-ID: <3A4CA9BD.E8E4D6E1@vnet.ibm.com>
Date: Fri, 29 Dec 2000 15:11:57 +0000
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: PowerPC branch out of date
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

  I'm one of the folks that works on the PowerPC portion of the kernel. I've
noticed for some time that what's available at kernel.org and what's being
worked on by those of us who maintain our little portion of the PowerPC tree is
more and more out of sync. 
  How it's got there etc etc etc at this stage isn't important. First how to fix
it and how to make sure it doesn't happen again does concern me.
  
  Currently the diff between test13-preX and the master fsmlabs.com ppc tree is
about 450k. Is the right thing to start with that patch get that into the
test13-preX series?

  I would REALLY appreciate it if this could be made to happen. I've got a whole
boatload of RS/6000 (aka pSeries) hardware that will be starting to work once
this patch is in. It's truely a shame to have to explain to people that
kernel.org *SHOULD* be the place to get a good kernel but given that things are
out of sync to have to point them somewhere else.
  
  Regards,

  Tom

-- 
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
