Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271830AbRICVdu>; Mon, 3 Sep 2001 17:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271831AbRICVdl>; Mon, 3 Sep 2001 17:33:41 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:23571 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271830AbRICVdb>; Mon, 3 Sep 2001 17:33:31 -0400
Date: Mon, 3 Sep 2001 23:35:26 +0200
From: Steffen Moser <lists@steffen-moser.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Parallel Port doesn't detect EPP
Message-ID: <20010903233526.P2725@steffen-moser.de>
Mail-Followup-To: "Udo A. Steinberg" <reality@delusion.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B93DE17.92CF408E@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B93DE17.92CF408E@delusion.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* On Mon, Sep 03, 2001 at 09:46 PM (+0200), Udo A. Steinberg wrote:

> I have just two questions regarding parallel port support with my
> Via686a chipset:
> 
> #1) EPP is no longer listed as supported transfer mode, but it used
>     to be.

What's your BIOS setting for your parallel port? 

I've got quite the same "problem" when setting it to "ECP+PPP". When 
configuring "EPP" mode it runs well (and my Iomega ZIP drive ("ppa") 
is able to use 32 bit mode) - I don't need "ECP" mode here.

My motherboard ist an "Epox 8kta+". 

Regards,
Steffen
