Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRHaUgn>; Fri, 31 Aug 2001 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269229AbRHaUgd>; Fri, 31 Aug 2001 16:36:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:29398 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269206AbRHaUgV>; Fri, 31 Aug 2001 16:36:21 -0400
Message-ID: <3B8FF504.1985B0FF@vnet.ibm.com>
Date: Fri, 31 Aug 2001 20:35:16 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
CC: engebret@us.ibm.com, linuxppc64-dev@lists.linuxppc.org
Subject: PATCH: iSeries Device Drives Update 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Enclosed is a patch to update/include the virtual iSeries device drivers. This
patch is against 2.4.9-ac5.

Both the ppc32 and ppc64 architectures are now supported.

In these device drivers are support for:

Virtual Ethernet
Virtual Harddrive (or DASD in IBM parlance)
Virtual Tape
Virtual CD

Rather than clog up the email system, please pick up the patch from:

ftp.kernel.org/pub/linux/kernel/people/tgall/iSeriesDDvs2.4.9-ac5.patch.gz

Regards,

Tom

-- 
Tom Gall - PPC64 Code Monkey     "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
