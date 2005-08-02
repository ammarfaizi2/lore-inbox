Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVHBRRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVHBRRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVHBRR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:17:27 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:60934 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261680AbVHBRR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:17:26 -0400
Message-ID: <42EFABAB.6010105@tmr.com>
Date: Tue, 02 Aug 2005 13:21:47 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Barnett <bahb@L8R.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Acer Aspire 1691WCLi no boot problem
References: <20050729122015.73165b54@be.back.l8r.net>
In-Reply-To: <20050729122015.73165b54@be.back.l8r.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Barnett wrote:
> 
> 
> Hey, 
> 
> I have a very odd problem with an Acer Aspire 1691WCLi.  This laptop will
> simply not boot with any Debian precompiled kernel, with the exception of
> Debian's 2.4.27-2 initrd kernel.  I have compiled my own kernels, using a
> vast array of options, 2.6.11, 2.6.12, 2.6.12.3, 2.6.13-rc4 and 2.4.27,
> they also all fail in exactly the same way.  I have tried with and without
> initrd, acpi, 386 or other processor options, as well as very lean,
> stripped down kernels.  I have tried with both lilo and grub, but both
> result in the same hang.

I have the same machine, and FC[234] all boot fine, but the damn sound 
doesn't work. FC3 just didn't work, FC4 hangs if I use "play test sound" 
but otherwise works.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
