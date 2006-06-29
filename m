Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWF2SO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWF2SO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWF2SO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:14:26 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:52997 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751234AbWF2SOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:14:25 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Marc Perkel <marc@perkel.com>
Subject: Re: AMD AM2 Sempron vs. Athlon - Confused
Date: Thu, 29 Jun 2006 19:14:39 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <44A40E50.5040901@perkel.com>
In-Reply-To: <44A40E50.5040901@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291914.39951.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 June 2006 18:30, Marc Perkel wrote:
> I'm confused and I thought if anyone would know it would be people here.
>
> So - in the AM2 world, what's the difference between Sempron and Athlon
> processors?

That I'm aware of, Semprons have smaller L2 caches. You want an Athlon.

> I look at the specs and they look really similar. Pricing is 
> even weirder with lower spec Semprons costing more than higher spec
> Athlons?

I've not seen this, but my understanding is that AMD's PR numbering scheme 
can't be used to compare between processor lines. i.e., a Sempron 3000+ is 
not faster than an Athlon 2800+..

> And - can Linux kernels run on these new processors and motherboards or
> is this just too new to mess with?

Should just work. I've seen Linux booted on an AM2 board, but I don't 
currently own one.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
