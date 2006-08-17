Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWHQWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWHQWfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWHQWfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:35:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:20713 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030277AbWHQWfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:35:47 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44E4EEC6.6040900@s5r6.in-berlin.de>
Date: Fri, 18 Aug 2006 00:33:42 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Andreas Herrmann <AHERRMAN@de.ibm.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-scsi-owner@vger.kernel.org,
       Matthew Wilcox <matthew@wil.cx>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: Random scsi disk disappearing
References: <OF23DA8DB2.DFFECE8E-ON422571CD.005B6F56-422571CD.005BA03C@de.ibm.com>
In-Reply-To: <OF23DA8DB2.DFFECE8E-ON422571CD.005B6F56-422571CD.005BA03C@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Herrmann wrote:
> Anyone interested in a script to conveniently interpret or change the
> SCSI logging level? Such a script (scsi_logging_level) exists in the
> s390-tools package (version 1.5.3).

That would be very welcome.

> If others show interest for this script, maybe a better place can be
> found than s390-tools (because it is not really s390-specific).

It could be put into linux/Documentation/scsi/. People who are 
confronted with a debugging problem probably look into Documentation/. 
Also, scripts which demonstrate usage of certain kernel interfaces do 
count as valuable documentation.
-- 
Stefan Richter
-=====-=-==- =--- =--=-
http://arcgraph.de/sr/
