Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbULMHWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbULMHWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 02:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbULMHWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 02:22:04 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:50692 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S262309AbULMHVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 02:21:53 -0500
Message-ID: <41BD4235.2030307@globaledgesoft.com>
Date: Mon, 13 Dec 2004 12:48:13 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Unterkircher <unki@netshadow.at>
CC: linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to enable sysrq feature
References: <41BD24EB.8000502@globaledgesoft.com> <41BD2D35.5080101@netshadow.at>
In-Reply-To: <41BD2D35.5080101@netshadow.at>
Content-Type: multipart/mixed;
 boundary="------------050809060006010400030602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809060006010400030602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andreas,

Here is the configuration of my system.

Regards,
Krishna Chaitanya

Andreas Unterkircher wrote:

> Hi
>
> .config looks correct - u should have at least
>
> /proc/sys/kernel/sysrq - to enable/disable   and
> /proc/sysrq-trigger - to trigger an sysrq event.
>
> do u really booted the correct kernel? :)
>
> The key combination won't work sometimes - in special cases.
> But in Documenation/sysrq.txt you will find some tricks.
>
> lg, Andi
>
> krishna wrote:
>
>> Hi all,
>>
>> I have installed a 2.6.9 linux box with sysrq enabled. But Alt + 
>> printscreen + h is not working. And there is no 
>> /proc/sys/kernel/sysrq in
>> the proc directory.
>>
>> Regards,
>> Krishna Chaitanya
>>


--------------050809060006010400030602
Content-Type: text/plain;
 name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log"

Linux marvell 2.6.9 #1 SMP Fri Dec 10 12:08:52 IST 2004 i686 unknown unknown GNU/Linux
 
Gnu C                  gcc (GCC) 3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               0.9.14
e2fsprogs              1.34
pcmcia-cs              3.2.5
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         


--------------050809060006010400030602--
