Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131793AbRCOT3N>; Thu, 15 Mar 2001 14:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131794AbRCOT2x>; Thu, 15 Mar 2001 14:28:53 -0500
Received: from raven.toyota.com ([63.87.74.200]:56592 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S131793AbRCOT2s>;
	Thu, 15 Mar 2001 14:28:48 -0500
Message-ID: <3AB117C5.45487A96@toyota.com>
Date: Thu, 15 Mar 2001 11:28:05 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
In-Reply-To: <Pine.LNX.4.33.0103152334400.1320-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Thu, 15 Mar 2001, J Sloan wrote:
>
> > Fun, yes, and perhaps not directly related, however
> > under high load, where the sheer numbet of interrupts
> > per second begins to overwhelm the kernel, might it
> > not be relevant?
>
> No.
>
> > Or are you saying that the bottleneck is somewhere
> > else completely,
>
> Indeed. The bottleneck is with processing the incoming network
> packets, at the interrupt level.

OK, I'll take this to kernel newbies!

:-)

Jup

