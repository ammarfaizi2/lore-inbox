Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269178AbRHQAGu>; Thu, 16 Aug 2001 20:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269184AbRHQAGk>; Thu, 16 Aug 2001 20:06:40 -0400
Received: from blackhole.compendium-tech.com ([64.156.208.74]:16528 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S269178AbRHQAGe>; Thu, 16 Aug 2001 20:06:34 -0400
Date: Thu, 16 Aug 2001 17:06:40 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: Justin A <justin@bouncybouncy.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM nuisance
In-Reply-To: <20010816192946.A20072@bouncybouncy.net>
Message-ID: <Pine.LNX.4.33.0108161704250.10866-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Justin A wrote:

> Though it is not a complete solution for all cases(servers etc),
> could a SysReq combination be added that triggers OOM?  I'm sure many
> people use SysReq-k on occasion to get a system out of endless
> swapping,  I think having a SysReq key for OOM would be a great
> improvement.
>
> Comments?

I think it's a damn good idea. I'd actually begin coding that now, if I
knew where to start. SysRQ has saved my life more than once -- i'm sure it
would help all the other people who are having problems with randomized
thrashing and stuff.

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

