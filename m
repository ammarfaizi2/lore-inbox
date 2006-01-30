Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWA3SNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWA3SNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWA3SNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:13:32 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:7430 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751277AbWA3SNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:13:31 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Heerath bh <heerath.bh@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Rebuilding Linux kernel
References: <aca19fda0601292303r5d3dba06kf40121a118f13c69@mail.gmail.com>
	<1138605742.2799.149.camel@mindpipe>
From: Nix <nix@esperi.org.uk>
X-Emacs: a learning curve that you can use as a plumb line.
Date: Mon, 30 Jan 2006 18:13:21 +0000
In-Reply-To: <1138605742.2799.149.camel@mindpipe> (Lee Revell's message of
 "30 Jan 2006 07:24:08 -0000")
Message-ID: <8764o1vb26.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2006, Lee Revell said:
> On Mon, 2006-01-30 at 12:33 +0530, Heerath bh wrote:
>> 
>> Basically  I am trying to rebuild the kernel.I am trying to make two
>> types of kernel.I am using Redhat 2.4 version on intel x86 machine.
>> 1.Deployment level kernel
>> 2.development level kernel.
>> 
>> Deployment Level kernel:This kernel has to be a Very vanilla kernel. I
>> mean to say, it wil be having basic kernel services like:preemptive
>> kernel,memory
>> 
>>  management,scheduling&synchronization,sysatem
>> timers,IPC,Interrupt handling,multitasking.
>> 
> 
> You will need 2.6 for this, 2.4 is inadeuate (no preemption).  2.6.14 or
> 2.6.15 is a good choice.

He wants it to fit in 300K (of RAM? final image size? he didn't say).

No way will normal Linux kernels get that trim, nor any Linux-like
kernel supporting all the features he wants.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
