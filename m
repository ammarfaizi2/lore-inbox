Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVCVMBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVCVMBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVCVMBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:01:47 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:18902 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262654AbVCVMBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:01:45 -0500
Message-ID: <42400927.5050902@ens-lyon.org>
Date: Tue, 22 Mar 2005 13:01:43 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i830 DRM problems
References: <422C5A25.3000701@ens-lyon.org>	<21d7e99705031115075e4378ed@mail.gmail.com>	<20050321151453.695c73e2.akpm@osdl.org>	<423F5A0A.7060307@ens-lyon.org> <20050321161356.5e1002dd.akpm@osdl.org>
In-Reply-To: <20050321161356.5e1002dd.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>>Sorry about that, we start to talk about it in private with Dave.
>>But, I did not really it since Keenan Pepper told me it was due
>>to a bug in the XFree 4.3 driver.
>>I am now using Xorg and didn't see any DRM problem since.
>>However, I can't confirm that my bug was surely due to the XFree driver 
>>and not to the kernel driver since Xorg uses i915 instead of i830.
>>Keenan, do you have details ?
> 
> 
> OK, that sounds promising.  Would you view this as a regression?  Was XFree
> 4.3 working OK on earlier 2.6 kernels?


 From what I remember, X had never been stable on this box.
So I'll vote for no regression here.
The main reason for this bug report was that I was tired
of getting a crash, say every two weeks. But now Xorg works
great.

Regards,

Brice
