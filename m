Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132727AbRC2Ttp>; Thu, 29 Mar 2001 14:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132823AbRC2Tth>; Thu, 29 Mar 2001 14:49:37 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:4310 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132727AbRC2TtZ>;
	Thu, 29 Mar 2001 14:49:25 -0500
From: tom_gall@vnet.ibm.com
Message-ID: <3AC3914E.B0EE39E3@vnet.ibm.com>
Date: Thu, 29 Mar 2001 19:47:26 +0000
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Obtaining new Device Numbers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  According to Documentation/devices.txt to request new major / numbers, all you
should have to do is get ahold of H. Peter Anvin.

  Does anybody know if he is still doing this? Perhaps has he passed this duty
on to someone else? It would appear he isn't answering requests mailed to
device@lanana.org.

  I'm trying to get the major / minor number issues resolved for the Linux port
to the IBM AS/400 aka iSeries. We have released our first set of patches and
before we put out the next set we'd like to get this nailed down as we're using
bogus major / minor numbers that we just grabbed out of mid-air... obviously not
the right thing.

  For those interested in the patches, take a gander to
oss.software.ibm.com/developerworks/opensource/linux/projects/ppc/iSeries_notes.php

  Thanks much for any info!

  Regards,

  Tom
-- 
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux
