Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRGGAtH>; Fri, 6 Jul 2001 20:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264381AbRGGAs5>; Fri, 6 Jul 2001 20:48:57 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:53434 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264375AbRGGAsj>; Fri, 6 Jul 2001 20:48:39 -0400
Date: Fri, 6 Jul 2001 17:48:38 -0700
From: "Daniel A. Nobuto" <ramune@bigfoot.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: natsemi.c failure in 2.4.6
Message-ID: <20010706174838.A477@bigfoot.com>
In-Reply-To: <3B459958.F25665A8@stud.uni-saarland.de> <20010706044046.A864@bigfoot.com> <3B45F966.351D1C44@colorfullife.com> <3B463C71.B217B275@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B463C71.B217B275@colorfullife.com>; from manfred@colorfullife.com on Sat, Jul 07, 2001 at 12:32:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 07, 2001 at 12:32:17AM +0200, Manfred Spraul wrote:
> Perhaps powermanagement causes your receive problems? You wrote you have
> a FA312. I've tested my FA311 (without mii-diag) and I didn't have any
> problems with transmit or receive.

Found out what was wrong.  It was hardware-related after all.  Sorry for
the confusion.  Turns out my cat chewed on my cables -- replacing them
fixed it.

Thanks for the help!

-- DN
Daniel
