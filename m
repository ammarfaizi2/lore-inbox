Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUHSXJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUHSXJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267493AbUHSXJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:09:01 -0400
Received: from opersys.com ([64.40.108.71]:36623 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S267510AbUHSXIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:08:12 -0400
Message-ID: <4125312F.7020108@opersys.com>
Date: Thu, 19 Aug 2004 19:01:03 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Miles Lane <miles.lane@comcast.net>
CC: linux-kernel@vger.kernel.org, Thomas Zanussi <trz@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
References: <200408191822.48297.miles.lane@comcast.net>
In-Reply-To: <200408191822.48297.miles.lane@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Miles Lane wrote:
> http://www.theregister.co.uk/2004/07/08/dtrace_user_take/:
> 
> "Sun sees DTrace as a big advantage for Solaris over other versions of Unix 
> and Linux."

We've been pushing for the inclusion of the Linux Trace Toolkit in the kernel
for the past 5 years. As of late, it seems that the pending argument against
its inclusion is: How is this useful to end users? In answer to that, I had
already posted the same pointer as above:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108938594031379&w=2

Since then, I've had the chance to discuss this matter at the Kernel Summit,
and again I was told that this was a sales problem (i.e. it must be
demonstrated that this is actually useful to users.) So, as the developers
of the Linux Trace Toolkit, it would help us a lot if you could explain to
this list why the sort of functionality provided by DTrace is something you
would personally find useful.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

