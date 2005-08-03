Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVHCBRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVHCBRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVHCBRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:17:30 -0400
Received: from dvhart.com ([64.146.134.43]:20667 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261941AbVHCBR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:17:29 -0400
Date: Tue, 02 Aug 2005 18:17:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <30040000.1123031853@[10.10.2.4]>
In-Reply-To: <20050728231029.0c0026bc.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org><159960000.1122616883@[10.10.2.4]> <20050728231029.0c0026bc.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Thursday, July 28, 2005 23:10:29 -0700):

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> NUMA-Q boxes are still crashing on boot with -mm BTW. Is the thing we 
>> identified earlier with the sched patches ...
>> 
>> http://test.kernel.org/9398/debug/console.log
> 
> Oh, thanks.  That's about 8,349 bugs ago and I'd forgotten.
> 
>> Works with mainline still (including -rc4) ... hopefully those patches 
>> aren't on their way upstream anytime soon ;-)
> 
> Well can you identify the offending patch(es)?  If so, I'll exterminate them.
> 
> 
> 

scheduler-cache-hot-autodetect.patch, I think.

will double-check.

M.

