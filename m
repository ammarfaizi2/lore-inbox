Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUHYBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUHYBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269069AbUHYBE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:04:56 -0400
Received: from mail.broadpark.no ([217.13.4.2]:404 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S269072AbUHYBEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:04:50 -0400
Message-ID: <412BE5CC.8020303@linux-user.net>
Date: Wed, 25 Aug 2004 03:05:16 +0200
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 0.7.2 (X11/20040712)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>
Cc: fraga@abusar.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.9-rc1
References: <4B2093FFC31B7A45862B62A376EA7176033C058D@mickey.topnz.ac.nz>
In-Reply-To: <4B2093FFC31B7A45862B62A376EA7176033C058D@mickey.topnz.ac.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sartorelli, Kevin wrote:
> Daniel Andersen wrote:
> 
>>As Linus initially said, there is the possibility of releasing 
>>a bug-fix patch 2.6.8.2 *after* 2.6.9 has been released.
> 
> 
> So, in this case, which would be considered the latest stable kernel to be used in production?  I can see this getting to a stage where you just pick and hope :-(
> 
> Cheers
> Kevin

This would normally be 2.6.9(.w). I did not point it out but Linus said 
-rc kernels.
Lately there has been some talk about removing deprecated features (eg. 
devfs, cryptoloop) which makes me think. Linus, is there a chance that 
there will be a x.y.z.W release of an old kernel after the next x.y.Z.w 
has been released and no longer is -rc? For example releasing a 2.6.8.2 
after 2.6.9 has been released and no longer is a 2.6.9-rcX.

In this case Kevin would have a point.

Daniel Andersen
--
