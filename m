Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVCBIQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVCBIQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 03:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVCBIQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 03:16:59 -0500
Received: from dns1.expertron.co.za ([196.25.64.193]:61922 "EHLO
	mail.expertron.co.za") by vger.kernel.org with ESMTP
	id S262217AbVCBIQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 03:16:58 -0500
Message-ID: <4225768B.3010005@expertron.co.za>
Date: Wed, 02 Mar 2005 10:17:15 +0200
From: Justin Schoeman <justin@expertron.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Tracing memory leaks (slabs) in 2.6.9+ kernels?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having a problem with memory leaking on a patched kernel.  In order 
to pinpoint the leak, I would like to try to trace the allocation points 
for the memory.

I have found some vague references to patches that allow the user to 
dump the caller address for slab allocations, but I cannot find the 
patch itself.

Can anybody please point me in the right direction - either for that 
patch, or any other way to track down leaking slabs?

Thank you,
Justin Schoeman
