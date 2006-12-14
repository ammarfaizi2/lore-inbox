Return-Path: <linux-kernel-owner+w=401wt.eu-S1750738AbWLNTcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWLNTcJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWLNTcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:32:09 -0500
Received: from main.gmane.org ([80.91.229.2]:53065 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbWLNTcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:32:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: Will there be security updates for 2.6.17 kernels?
Date: Thu, 14 Dec 2006 20:33:49 +0100
Message-ID: <els8qm$vh2$1@sea.gmane.org>
References: <elrop2$vdl$1@sea.gmane.org> <9a8748490612140710o478bf73p7efc607f545cf499@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e4389e.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.8) Gecko/20061108 SeaMonkey/1.0.6
In-Reply-To: <9a8748490612140710o478bf73p7efc607f545cf499@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl schrieb:
> No, that is not planned. 2.6.16.x is an exception.    -stable kernels
> (those with 2.6.x.y versions) are only released for the latest stable
> 2.6.x kernel. So currently that's 2.6.19 and as soon as 2.6.20 comes
> out there will not be any more 2.6.19.x, only 2.6.20.x   - I hope
> that's clear...

Yes, I think that's clear, but are those "stable" kernels really 
"stable". Stable would be a kernel which only gets security updates and 
maybe some new drivers, but not mayor changes in concept, which may 
require to modify config scripts, init scripts or whatever in system.

I think the 2.6.16.x would be something like this. It should do the job 
until the next 2.6.x is nominated to get future security updates.

> Not true. Slackware updates the kernel to fix security issues - this
> has been the case in the past and i don't see why it would change in
> the future.

Yes, that's true. They updated the 2.4.x kernel at least once, but they 
updated the kernel with an official kernel.org kernel. What I tried to 
say is, that they don't create their own kernel patches to fix critical 
security bugs in the kernels, they ship (at least as far as I know).

I just assume that they planned to stay with 2.6.17 for Slackware 11, as 
this kernel works for all the other packages, scripts, ...

>> Could someone please give two examples? I need
>> informations, to be able to contact the slackware team, to request a
>> "downgrade" to 2.6.16.
>>
> Ehh, you wouldn't want to do that. You'd want to encourage an upgrade
> to 2.6.19.1 instead.

I don't think they want to go that way. This would just mean that they 
have to create too much updates. Maybe even one of those "stable" 
kernels has a major bug (there was an XFS bug in the past. One of my 
friends, who regularly compiled new kernels, lost files that way).

If 2.6.16 is the "real stable" branch, then I'd vote for using this one.

But it's not my decision. Anything I needed to know is that there will 
be definetly no more security updates for 2.6.17.

Yours

Manuel Reimer

