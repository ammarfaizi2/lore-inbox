Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUIHNxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUIHNxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUIHNw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:52:58 -0400
Received: from relay-6v.club-internet.fr ([194.158.96.111]:27581 "EHLO
	relay-6v.club-internet.fr") by vger.kernel.org with ESMTP
	id S267923AbUIHNwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:52:24 -0400
From: pinotj@club-internet.fr
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Supported architectures for Linux 2.6
Date: Wed,  8 Sep 2004 15:52:13 CEST
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet2.1094651533.2169.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russel King wrote:
>>
>> I updated the documentation I wrote about architectures supported by
>> the 2.6.X kernel. Here is the beginning for the curious:
>>...
>> The complete file is available here :
>> http://cercle-daejeon.homelinux.org/linux/kernel/arch.txt 
>
>Sorry, I don't have much interest in keeping this up to date for ARM
>platforms; there are too many ARM platforms around which would make
>this a full time job.

I understand, Linux is too much portable :-)
I don't expect we can write a complete and accurate list of all arch in one shot.
It is something that must evolve like the Kernel or Hardware does.

>I'm not certain that all the ARM platforms we appear to support in
>2.6.x are actually working - again, it comes back to time, people and
>testing.

Of course, it will take time. 

What do you think about creating a Wiki from this file that users/maintainers could update easily ?

The portability of Linux shouldn't be underestimate by non-expert people. I believe this file could help.

Regards,

(please, cc: me)

--
Jerome Pinot
http://cercle-daejeon.homelinux.org/linux

