Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVHYVuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVHYVuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVHYVuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:50:00 -0400
Received: from math.ut.ee ([193.40.36.2]:41200 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S964870AbVHYVt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:49:59 -0400
Date: Fri, 26 Aug 2005 00:49:34 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Masoud Sharbiani <masouds@masoud.ir>
Subject: Re: 2.6.13-rc6: halt instead of reboot
In-Reply-To: <m11x4iofmw.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.SOC.4.61.0508260047170.10568@math.ut.ee>
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
 <m14q9iva4q.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
 <m1mznativw.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0508242252120.20856@math.ut.ee>
 <m11x4iofmw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm searching my way through changesests.

rc2 was OK, rc3 was broken.
60a762b6a6dec17cc4339b60154902fd04c2f9f2 was OK too - the commit before 
ACPI merge on 2005-07-12

Currently compiling 5028770a42e7bc4d15791a44c28f0ad539323807 - acpi 
merge commit. Will see tomorroy whether it works.

-- 
Meelis Roos (mroos@linux.ee)
