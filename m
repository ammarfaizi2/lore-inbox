Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUIWBgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUIWBgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUIWBgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:36:39 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:14814 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268127AbUIWBgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:36:36 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: NOT FIXED (Is anyone using vmware 4.5 with 2.6.9-rc2-mm
Date: Wed, 22 Sep 2004 22:36:26 -0300
User-Agent: KMail/1.7
Cc: Kyle Schlansker <kylesch@gmail.com>, linux-kernel@vger.kernel.org
References: <4506E4E6490@vcnet.vc.cvut.cz> <aeb13402040922144553f096c7@mail.gmail.com> <8250D402-0CEC-11D9-B9FD-000D9352858E@linuxmail.org>
In-Reply-To: <8250D402-0CEC-11D9-B9FD-000D9352858E@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409222236.26323.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> > I must have missed the previous discussion, so
> > what issues are you having (i.e. how does vmware "not work")?
>
> I think all the problems he is having are related to the fact that he
> has a "tmpfs" mounted on top of "/tmp". 

Exactly, I have tmpfs mounted on /tmp; but why does it work with kernels up to 
2.6.9-rc1-mm5? I'm an ignorant on all this so an explanation would be nice.


> I'm also using VMware with 
> 2.6.9-rc2-mm1 with a plain, disk-based, /tmp directory, with no
> problems at all.

I'll try a plain /tmp directory, but I'd like to know why I can't use tmpfs 
anymore with kernels >=2.6.9-rc2-mm1.

Many thanks in advance,
Norberto
