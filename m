Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWFBPik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWFBPik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWFBPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:38:40 -0400
Received: from arachne.linuxlabs.com ([208.176.116.10]:64944 "EHLO
	arachne.taloncorporation.com") by vger.kernel.org with ESMTP
	id S932373AbWFBPij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:38:39 -0400
Date: Fri, 2 Jun 2006 11:38:37 -0400 (EDT)
From: Steven James <pyro@linuxlabs.com>
X-X-Sender: pyro@localhost.localdomain
To: Jeff Dike <jdike@addtoit.com>
cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net, discuss@x86-64.org,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: [uml-devel] [discuss] [RFC] [PATCH] Double syscall exit traces
 on x86_64
In-Reply-To: <20060602151335.GA4708@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.63.0606021136440.26283@localhost.localdomain>
References: <20060526032424.GA8283@ccure.user-mode-linux.org>
 <200605261236.26814.ak@suse.de> <20060526141345.GA4152@ccure.user-mode-linux.org>
 <200606012107.34676.blaisorblade@yahoo.it> <20060602151335.GA4708@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006, Jeff Dike wrote:

> On Thu, Jun 01, 2006 at 09:07:33PM +0200, Blaisorblade wrote:
>> Sorry for the question, but has this been sent to -stable (since it's a
>> -stable regression, it should be)? To 2.6.17 -git?
>
> It's in current git.
>
> I'm having a hard time telling when the bug was introduced.  The git web
> interface seems to be telling me that the double notification was around
> since last year, which I don't believe, since I've run much more
> recent x86_64 kernels.  If the bug existed before 2.6.16, then it's
> fine -stable fodder.

I know that the bug is NOT present in 2.6.15.7.

>
>> And have you tested it (somebody should have, but it's not sure)?
>
> Yes, it's been continuously and happily running UML since Andi sent me
> his patch.
>
> 				Jeff
>
