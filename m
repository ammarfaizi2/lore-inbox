Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274277AbRITAUG>; Wed, 19 Sep 2001 20:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274284AbRITAT4>; Wed, 19 Sep 2001 20:19:56 -0400
Received: from [24.254.60.19] ([24.254.60.19]:27086 "EHLO
	femail29.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274277AbRITATy>; Wed, 19 Sep 2001 20:19:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 17:19:06 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010919154701.A7381@stud.ntnu.no> <20010919165503.A16359@gondor.com> <9oafeu$1o0$1@penguin.transmeta.com>
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01091917190600.00628@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 September 2001 09:00 am, Linus Torvalds wrote:
> In article <20010919165503.A16359@gondor.com>,

>
> Right now, for example, I'm leaning towards applying the patch, but
> quite frankly I'm still not certain.  Getting _some_ kind of
> information out of VIA would be really good - even just an ACK from
> somebody who is under NDA and can say just "yes, it's safe to clear bit
> 7 of reg 0x55".
>

Is there an way someone could find out what Windows, possibly with VIA's 
4-in-1 drivers, do with this bit? And for that matter, what the test 
program that tests it regardless of kernel optimizations does in Windows, 
if it can be ported?
