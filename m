Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266428AbRGJOdM>; Tue, 10 Jul 2001 10:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbRGJOcw>; Tue, 10 Jul 2001 10:32:52 -0400
Received: from ns.caldera.de ([212.34.180.1]:27336 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S266428AbRGJOcv>;
	Tue, 10 Jul 2001 10:32:51 -0400
Date: Tue, 10 Jul 2001 16:32:43 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010710163243.A8818@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
	hpa@zytor.com
In-Reply-To: <20010710161943.A7785@caldera.de> <20010711022509.C31966@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010711022509.C31966@weta.f00f.org>; from cw@f00f.org on Wed, Jul 11, 2001 at 02:25:09AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 02:25:09AM +1200, Chris Wedgwood wrote:
> What is the limit here? The 8/16 way SE chipsets?

The largest Chipset I know about are the 8 Way ones.
(What is SE?).

>     > In anyone from Compaq is reading this, you should send me a 32-way
>     > Xeon ASAP just to prove they really work :)
>     
>     It doesn't.
> 
> Oh, then they definately need to send me one.

Heh :)

> Are these not MP1.4 based? Something different?

They must be the Unisys OEM machines.  They are based on some
crossbar-architecture called CMP that allows logical partioning, etc..

I have talked to Unisys engineers on last Cebit who said that the NT
(now W2k) port required a huge amount of work.
Also I noticed that UnixWare^H^H^H^H^HOpenUnix needed work to run on it.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
