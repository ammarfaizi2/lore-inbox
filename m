Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSKUCGO>; Wed, 20 Nov 2002 21:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbSKUCGO>; Wed, 20 Nov 2002 21:06:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11759 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266286AbSKUCGN>;
	Wed, 20 Nov 2002 21:06:13 -0500
Date: Wed, 20 Nov 2002 18:21:27 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>,
       Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 6 sys_poll/sys_select performance patches
Message-ID: <65860000.1037845287@w-hlinder>
In-Reply-To: <Pine.LNX.4.44.0211201628471.974-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0211201628471.974-100000@blue1.dev.mcafeelabs.com
 >
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, November 20, 2002 04:29:16 PM -0800 Davide Libenzi 
<davidel@xmailserver.org> wrote:

>> What do you think? Are there any apps/tests/benchmarks that stress
>> sys_poll or sys_select?
>
> You can try Ben's pipetest ...

The pointer for which can be found (with detailed testing instructions)
at: http://lse.sf.net/epoll

Hanna



