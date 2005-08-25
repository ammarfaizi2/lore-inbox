Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVHYCwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVHYCwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVHYCwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:52:41 -0400
Received: from mail.cs.unm.edu ([64.106.20.33]:47049 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S932501AbVHYCwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:52:40 -0400
Message-ID: <430D3269.5020507@cs.unm.edu>
Date: Wed, 24 Aug 2005 20:52:25 -0600
From: Sushant Sharma <sushant@cs.unm.edu>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050531)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hardware Perfromance Counters
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
The system I am working on is a single processor Athlon. In the kernel I 
need to detect a cache miss (L1/L2) and trigger an event/function 
(inside the kernel). Now we have performance counters for 
detecting/counting cache misses. Among the various tools/patches 
available for accessing performance counters, which one do you guys 
recommend. Or do you think it would be easy to write code for this 
myself, as i just need this one event detection. Can you give some links 
where one can read about programming performance counters or some book 
on it.

Thanks a lot.
please cc reply to me too.

--

Sushant Sharma
http://cs.unm.edu/~sushant
