Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUHUUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUHUUtr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUHUUqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:46:51 -0400
Received: from [138.15.108.3] ([138.15.108.3]:37096 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S267834AbUHUUqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:46:23 -0400
Message-ID: <4127B49A.6080305@nec-labs.com>
Date: Sat, 21 Aug 2004 16:46:18 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
References: <4127A15C.1010905@nec-labs.com> <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com> <20040821215055.GB7266@mars.ravnborg.org>
In-Reply-To: <20040821215055.GB7266@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Aug 2004 20:46:10.0837 (UTC) FILETIME=[E4160C50:01C487BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about multi-file module?

Say test.c doesn't include stdio.h, while there is some other .c file 
which is to be compiled and linked into test.ko, include stdio?

Would that work?

TIA!
Lei
Sam Ravnborg wrote:
> On Sat, Aug 21, 2004 at 03:45:38PM -0400, Lei Yang wrote:
> 
>>You mean I can't use stdio.h at all?
> 
> Correct.
> 
>>But what if I really need to? Is there anything I can do?
> 
> Try to explain what you need. Then maybe someone on the list can help you.
> 
> 	Sam
