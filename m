Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVAWCqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVAWCqW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVAWCqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:46:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:22926 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261189AbVAWCqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:46:18 -0500
Message-ID: <41F30E0A.9000100@osdl.org>
Date: Sat, 22 Jan 2005 18:38:02 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, diego@pemas.net
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a threading
 error
References: <217740000.1106412985@[10.10.2.4]>
In-Reply-To: <217740000.1106412985@[10.10.2.4]>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Please contact bug submitter for more info, not myself.
> 
> ---------------------------------------------
> 
> http://bugme.osdl.org/show_bug.cgi?id=4081
> 
>            Summary: OpenOffice crashes while starting due to a threading
>                     error
>     Kernel Version: 2.6.11-rc2
>             Status: NEW
>           Severity: blocking
>              Owner: process_other@kernel-bugs.osdl.org
>          Submitter: diego@pemas.net
> 
> 
> Distribution: Debian
> Hardware Environment: Pentum III 733 MHz
> Software Environment: Debian Sid
> Problem Description:
> While starting open Office crashes, it did not happend on 2.6.10, but happend on
> 2.6.11. rc1 and rc2. The only thing that has changed is the kernel. If i go back
> to 2.6.10 OpenOffice starts just fine.

OO works for me on 2.6.11-rc2, but my OO is 1.1.1.
The bugzilla mentions 1.1.2yyy and 1.1.3zzz, so I'd see if you
(diego) can try some 1.1.3 OO.

-- 
~Randy
