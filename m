Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTLCRhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTLCRhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:37:48 -0500
Received: from mail.gmx.de ([213.165.64.20]:15580 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263895AbTLCRhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:37:47 -0500
X-Authenticated: #4512188
Message-ID: <3FCE1F64.6020602@gmx.de>
Date: Wed, 03 Dec 2003 18:37:40 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <3FCD21E1.5080300@netzentry.com> <1070411338.2452.66.camel@athlonxp.bradney.info> <3FCD32F5.2050002@gmx.de> <200312031709.MAA18860@gatekeeper.tmr.com>
In-Reply-To: <200312031709.MAA18860@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> In article <3FCD32F5.2050002@gmx.de>,
> Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:
> | > smp off, preempt off. lapic on, apic on, acpi on
> | 
> | Why haven't you enabled preempt? Does it lock with preempt on?
> 
[snip]
> Have you seen a benefit from preempt? And if so, what application and
> how much? I may not be doing anything which benefits from preempt enough
> to notice (news, mail and dns servers, desktops), but other than dns on
> 2.4 I haven't seen improvement.
> 
> enlightenmet, please?

Well, I am fairly new to Linux. Only since a month or so I am regurlarly 
using Linux and only since 2.6 kernel. I always used preempt and had no 
problems. The only problem I have, is with APIC. 2.6 is very smooth for 
me. I don't know whether it is because of preempt or not. I just was 
curious, why Craig didn't use it and whether the is a connection.

Prakash


