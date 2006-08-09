Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWHINuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWHINuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWHINuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:50:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:62221 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750817AbWHINux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:50:53 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,225,1151910000"; 
   d="scan'208"; a="113984458:sNHT48049148"
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: Acpi oops 2.6.17.7 vanilla
Date: Wed, 9 Aug 2006 21:50:34 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1120723@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Acpi oops 2.6.17.7 vanilla
Thread-Index: Aca7sETldUkdnMAATry/vMwNPcROrwACmguQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Johan Rutgeerts" <johan.rutgeerts@mech.kuleuven.be>,
       <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Aug 2006 13:50:38.0455 (UTC) FILETIME=[CBD2F870:01C6BBBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please open a bug on bugzilla.kernel.org in ACPI category

Thanks
Luming 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org 
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Johan Rutgeerts
Sent: 2006Äê8ÔÂ9ÈÕ 20:33
To: linux-acpi@vger.kernel.org
Cc: Brown, Len; linux-kernel@vger.kernel.org
Subject: Acpi oops 2.6.17.7 vanilla



Hi,


I frequently get kernel oopses (NULL pointer dereference), 
which seem acpi 
related.


Attached file contains kern.log info for a non-tainted 2.6.17.7 vanilla 
kernel.



If it is of interest: I have put lots of similar oops reports 
online, for 
different kernels versions (ubuntu kernels and vanilla), at:
<http://people.mech.kuleuven.be/~jrutgeer/oopses/>.

For the earlier kernels of those, I used to have a lot of 
"ACPI: read EC, IB 
not empty" messages. These seem gone since I compiled a vanilla 
2.6.17.7 
kernel.


I'm testing a 2.6.18-rc4 kernel now. If there is anything else 
I can do (e.g. 
test older kernels), please let me know.



Greetings,

Johan Rutgeerts


Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm
