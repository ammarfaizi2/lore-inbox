Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUCKIrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUCKIrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:47:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:8913 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262972AbUCKIrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:47:03 -0500
X-Authenticated: #4512188
Message-ID: <40502794.60907@gmx.de>
Date: Thu, 11 Mar 2004 09:47:16 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Schlichter <thomas.schlichter@web.de>
CC: Len Brown <len.brown@intel.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Dominik Brodowski <linux@brodo.de>
Subject: Re: ACPI PM Timer vs. C1 halt issue
References: <404E38B7.5080008@gmx.de> <1078956711.2557.72.camel@dhcppc4> <404F9B5B.6010207@gmx.de> <200403110115.36257.thomas.schlichter@web.de>
In-Reply-To: <200403110115.36257.thomas.schlichter@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter wrote:
> you may try to boot with ACPI PM timer enabled but with the additional boot 
> option 'noapic'. If this also cools down your processor, you maybe should try 
> the attached patch....

I am currently not using APIC, so above wouldn't make a difference.

bye,

Prakash
