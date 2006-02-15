Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWBOErq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWBOErq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 23:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWBOErq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 23:47:46 -0500
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:33041 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1422825AbWBOErq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 23:47:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
Date: Wed, 15 Feb 2006 10:17:35 +0530
Message-ID: <88299102B8C1F54BB5C8E47F30B2FBE201EC0D02@inblr-exch1.eu.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
Thread-Index: AcYxK64dPkta/derQIa+X0Fnt+L7wQAvjr9w
From: "Suryanarayanan, Rajaram" <Rajaram.Suryanarayanan@in.unisys.com>
To: "KUROSAWA Takahiro" <kurosawa@valinux.co.jp>, <vatsa@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <ckrm-tech@lists.sourceforge.net>,
       <balbir.singh@in.ibm.com>
X-OriginalArrivalTime: 15 Feb 2006 04:47:38.0055 (UTC) FILETIME=[F21A3570:01C631EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  	
-----Original Message-----
From: KUROSAWA Takahiro [mailto:kurosawa@valinux.co.jp] 
Sent: Tuesday, February 14, 2006 11:28 AM
To: vatsa@in.ibm.com
Cc: Suryanarayanan, Rajaram; linux-kernel@vger.kernel.org;
ckrm-tech@lists.sourceforge.net; balbir.singh@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller

On Tue, 14 Feb 2006 11:08:52 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> > It's not a forward port of the existing CPU resource controller 
> > but a new CPU resource controller for CKRM.  Its resource control
> > mechanism is different from that of the existing one.
> 
> Hmm ..I guess it depends on which version of CKRM you are referring
when
> you say "existing". When I replied earlier, I was referring to
f-series.
> f-series cpu controller is based on the patch you sent to lkml right?

Ah, I referred to the CKRM e- series controller as "existing controller"
and referred to the controller that I had sent as "a new CPU resource 
controller."

So, the controller that I had sent is the existing controller of
f- series.

Sorry for confusion,

-- 
KUROSAWA, Takahiro


Thanks for the clarification.
I was actually confused by the words "This patchset adds a CPU resource
controller for CKRM" in the earlier mail. I thought this is some new
controller..
Currently I have downloaded cpurc_v0.3-2614 and plan to look in to it
for understanding CKRM. Later I guess I can catch up with the current
changes that you are making..

Regards,
Rajaram Suryanarayanan | Team Lead | ES7000 Linux Systems Group    
Unisys Global Services -India | 
'Purva Premier', 135/1, Residency Road, | Bangalore - 560 025 |
+91-80-51594560
Do your best. Leave the rest to Linux.  	

