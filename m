Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264715AbUEOTlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264715AbUEOTlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264716AbUEOTlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:41:52 -0400
Received: from mail.tmr.com ([216.238.38.203]:20118 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S264715AbUEOTlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:41:51 -0400
Message-ID: <40A67424.7010408@tmr.com>
Date: Sat, 15 May 2004 15:48:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <Pine.LNX.3.96.1040512115750.23213A-100000@gatekeeper.tmr.com> <1084378819.10949.0.camel@laptop.fenrus.com>
In-Reply-To: <1084378819.10949.0.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>>"4KSTACKS" already is present in the module version string.
>>>
>>>And Fedora is shipping now with 4k stacks, so presumably any disasters
>>>are relatively uncommon...
>>
>>Fedora and kernel.org have a lot of unshared bugs and features,
>>unfortunately. I take that information as an encouraging proof of concept,
>>not a waranty that the kernel.org code will behave in a similar way.
> 
> 
> Hey! That's slander of title! :-)
> Seriously the difference between the Fedora Core 2 kernel and the
> matching kernel.org kernel aren't THAT big. The 4g/4g split patch being
> the biggest delta.
> 
I was thinking about the one you charge for... I wouldn't use FCn for 
production on a bet. I was thinking of my RHEL AS3.0 vs. kernel.org, 
which are kernels stable enough for commercial use.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
