Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUIWB6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUIWB6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUIWB6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:58:50 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:3588 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S268137AbUIWB6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:58:49 -0400
In-Reply-To: <200409222236.26323.norberto+linux-kernel@bensa.ath.cx>
References: <4506E4E6490@vcnet.vc.cvut.cz> <aeb13402040922144553f096c7@mail.gmail.com> <8250D402-0CEC-11D9-B9FD-000D9352858E@linuxmail.org> <200409222236.26323.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <19102930-0D04-11D9-B9FD-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: Kyle Schlansker <kylesch@gmail.com>, linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: NOT FIXED (Is anyone using vmware 4.5 with 2.6.9-rc2-mm
Date: Thu, 23 Sep 2004 03:58:43 +0200
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 23, 2004, at 03:36, Norberto Bensa wrote:

> Felipe Alfaro Solana wrote:
>>> I must have missed the previous discussion, so
>>> what issues are you having (i.e. how does vmware "not work")?
>>
>> I think all the problems he is having are related to the fact that he
>> has a "tmpfs" mounted on top of "/tmp".
>
> Exactly, I have tmpfs mounted on /tmp; but why does it work with 
> kernels up to
> 2.6.9-rc1-mm5? I'm an ignorant on all this so an explanation would be 
> nice.
>
>
>> I'm also using VMware with
>> 2.6.9-rc2-mm1 with a plain, disk-based, /tmp directory, with no
>> problems at all.
>
> I'll try a plain /tmp directory, but I'd like to know why I can't use 
> tmpfs
> anymore with kernels >=2.6.9-rc2-mm1.

That's a question that requires far more knowledge than I have.
Maybe someone here... Andrew?

