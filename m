Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbRE1Xn4>; Mon, 28 May 2001 19:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbRE1Xnq>; Mon, 28 May 2001 19:43:46 -0400
Received: from mailf.telia.com ([194.22.194.25]:52443 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S261806AbRE1Xnh>;
	Mon, 28 May 2001 19:43:37 -0400
Date: Tue, 29 May 2001 01:44:07 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <anedah-9@sm.luth.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
Message-ID: <20010529014406.A320@sm.luth.se>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0105281802290.1261-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0105281802290.1261-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.18i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> Just to confirm this is what happening in your case:  Can you please try
> 2.4.4-ac5 and see if the _swap usage_ is still as badly?

2.4.4-ac5 seams to use the swap about as much as 2.4.4, which is less than
2.4.5-ac2. In my simple "freesly boot kernel, start X and Mozilla" test
2.4.4-ac5 showed almost identical 'free' output as 2.4.4:

             total       used       free     shared    buffers     cached
Mem:         62760      61368       1392          0       1828      28760
-/+ buffers/cache:      30780      31980
Swap:       160608          0     160608

> Back to the interactivity issue, I suppose you've "felt" bad interactivity
> with 2.4.* kernels, right ?

Yes, I feel bad interactivety with later 2.4.4-acX kernels, and 2.4.5
kernels. Switching between apps and such feels a lot slower.

Let me know if you want me to do more tests.
-- 

André Dahlqvist <anedah-9@sm.luth.se>
