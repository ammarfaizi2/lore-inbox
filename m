Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUIVXLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUIVXLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUIVXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:11:19 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2308 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S268100AbUIVXKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:10:00 -0400
In-Reply-To: <aeb13402040922144553f096c7@mail.gmail.com>
References: <4506E4E6490@vcnet.vc.cvut.cz> <aeb13402040922144553f096c7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8250D402-0CEC-11D9-B9FD-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: NOT FIXED (Is anyone using vmware 4.5 with 2.6.9-rc2-mm
Date: Thu, 23 Sep 2004 01:09:52 +0200
To: Kyle Schlansker <kylesch@gmail.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 22, 2004, at 23:45, Kyle Schlansker wrote:

>>> * vmware with 2.6.9-rc1-mm5 works.
>>> * vmware with 2.6.9-rc2-mm1 doesn't work.
>
> I have vmware 4.5 running on 2.6.9-rc2-mm1 as well as 2.6.9-rc2-mm1
> running within vmware.  I must have missed the previous discussion, so
> what issues are you having (i.e. how does vmware "not work")?

I think all the problems he is having are related to the fact that he 
has a "tmpfs" mounted on top of "/tmp". I'm also using VMware with 
2.6.9-rc2-mm1 with a plain, disk-based, /tmp directory, with no 
problems at all.

