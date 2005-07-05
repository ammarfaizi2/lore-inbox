Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVGFFqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVGFFqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVGFFqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:46:50 -0400
Received: from cse-mail.unl.edu ([129.93.165.11]:58524 "EHLO cse-mail.unl.edu")
	by vger.kernel.org with ESMTP id S261749AbVGFD6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:58:14 -0400
Message-ID: <42CAA01F.2060001@cse.unl.edu>
Date: Tue, 05 Jul 2005 22:58:39 +0800
From: Neo Jia <cjia@cse.unl.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to debug the kernel for X86_64 SMP?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

These days, I am trying to debug the kernel (2.6.9) on x86_64 SMP. But 
the Kprobes and UML cannot work probably for my case, due to the patch 
file for x86_64 arch.

Is there anyone who is working on the same topic? Any hint and help 
would be appreciated!

Thanks,
Neo

-- 
I would remember that if researchers were not ambitious 
probably today we haven't the technology we are using! 

