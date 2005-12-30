Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVL3XLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVL3XLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVL3XLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:11:13 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:29840 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S964935AbVL3XLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:11:12 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark v Wolher <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 =?iso-8859-1?q?hours=09/=09random=09apps=09crashing?=
Date: Fri, 30 Dec 2005 23:11:27 +0000
User-Agent: KMail/1.9
Cc: Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <43B53EAB.3070800@ns666.com> <1135980690.31111.35.camel@mindpipe> <43B5B1C4.7070501@ns666.com>
In-Reply-To: <43B5B1C4.7070501@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512302311.27125.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 December 2005 22:16, Mark v Wolher wrote:
[snip]
> >
> > Basically you are asking for help with an unsupported configuration.  In
> > general people on LKML will be more helpful if you take the time to find
> > out what the bug reporting guidelines are before posting.
> >
> > Lee
>
> Thank you for your input, but sometimes thinking out of the box gives a
> solution instead of hiding behind "guidelines".

I'm surprised Lee fed you this long, but the cold hard fact of the matter is 
that you are posting to the Linux kernel mailing lists, and you will comply 
with these guidelines if you expect help.

I'm sure the problem might not be with VMWare, but there is absolutely nothing 
stopping you from switching nvidia with nv, not loading nvidia/vmware 
modules, then running the TV card doing *something else* for a few hours. If 
you do not detect lockups, contact VMWare. They will probably do the exact 
opposite of what Lee has done and suggest non-VMWare parts of the system are 
at fault.

However, unlike VMWare or NVIDIA, we can actually debug problems if you use 
source-available modules. Thinking outside of the box here is irrelevant -- a 
problem requires logical procedure to gain a solution. Any engineer will tell 
you the same thing. Ordinarily, this is test, observe, retest, and all Lee is 
suggesting is that you do *not* load the proprietary modules.

Try it before responding to this email, so you do not have to write another.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
