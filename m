Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUDAWZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUDAWZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:25:53 -0500
Received: from harddata.com ([216.123.194.198]:64485 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id S263121AbUDAWZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:25:48 -0500
From: Mark <mark@harddata.com>
Organization: Hard Data Ltd
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Upgrade from 2.4.25 to 2.6.4 kernel
Date: Thu, 1 Apr 2004 15:24:12 -0700
User-Agent: KMail/1.6.1
References: <20040401205344.546715FB7B@mail.metropipe.net>
In-Reply-To: <20040401205344.546715FB7B@mail.metropipe.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200404011524.12034.mark@harddata.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 1, 2004 03:49 pm, "Job 317" <job317@mailvault.com> wrote:
> Hello list.
>
> Can someone please point me to a HOWTO on installing a 2.6.x kernel on a
> system that heretofore runs a 2.4.x kernel?

http://kerneltrap.org/node/view/799 

BTW Google is your friend here. Do a search for 2.6 HOWTO and that link is the 
first one on the list.
>
> NOT a howto on building the kernel. I'm o.k. there. But I understand
> that it is not the same upgrading to a 2.6.x kernel as it is just
> upgrading to the next 2.4.x kernel. Is this correct?

No, a 2.6 kernel will run without changes to RedHat 9 but some changes should 
be made.

> Aren't there 
> startup scripts and things that rely on the 2.4.x structure that change
> slightly for a 2.6.x kernel?
>

Yes, check out the link above. There are also some links to RedHat 9 specific 
instructions.

> !!!!Also... is it possible to still to boot back to a 2.4.x kernel in
> this case?

Yep you can still run a 2.4.x kernel.

> Lets say I keep my 2.4.25 kernel that I built on my RedHat 9 
> box. Can I also boot to and from my 2.6.x kernel?

Yes

-- 
Mark Lane, CET mailto:mark@harddata.com 
Hard Data Ltd. http://www.harddata.com 
T: 01-780-456-9771   F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--
