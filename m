Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVACWIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVACWIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVACWFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:05:41 -0500
Received: from smtpout.mac.com ([17.250.248.85]:61413 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261903AbVACWES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:04:18 -0500
In-Reply-To: <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Mon, 3 Jan 2005 23:03:53 +0100
To: Rik van Riel <riel@redhat.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2005, at 22:48, Rik van Riel wrote:

> On Mon, 3 Jan 2005, Felipe Alfaro Solana wrote:
>> On 3 Jan 2005, at 21:59, Horst von Brand wrote:
>
>>> Open up the code. Most of the changes will then be done as a matter 
>>> of
>>> course by others.
>>
>> Unfortunately, you can't force the entire hardware industry to open 
>> up their drivers.
>
> That's ok.  I don't have to buy that hardware.

Gosh! I bought an ATI video card, I bought a VMware license, etc.... I 
want to keep using them. Changing a "stable" kernel will continuously 
annoy users and vendors.

I think new developments will force a 2.7 branch: when 2.6 feature set 
stabilizes, people will keep more time testing a stable, relatively 
static kernel base, finding bugs, instead of trying to keep up with 
changes.

