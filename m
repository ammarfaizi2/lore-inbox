Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270611AbUJUKnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270611AbUJUKnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJUKnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:43:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:16264 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270611AbUJUKnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:43:14 -0400
Message-ID: <417792BA.8090205@in.ibm.com>
Date: Thu, 21 Oct 2004 16:13:06 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vara Prasad <varap@us.ibm.com>
Subject: kexec based crashdumps
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patchset completes the basic functionality on 
kexec based crashdumps on i386. The first patch makes it 
possible to boot an i386 kernel from a non-default physical 
address. The rest of the patches are minor clean-ups and 
bug-fixes.

All the patches are on top of 2.6.9-rc4-mm1.

Kindly review them and let us know your feedback.

Thanks and Regards,
Hari
