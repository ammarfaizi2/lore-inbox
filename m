Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264503AbRFOUFi>; Fri, 15 Jun 2001 16:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264504AbRFOUF3>; Fri, 15 Jun 2001 16:05:29 -0400
Received: from quattro.sventech.com ([205.252.248.110]:22544 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S264503AbRFOUFU>; Fri, 15 Jun 2001 16:05:20 -0400
Date: Fri, 15 Jun 2001 16:05:19 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Kelledin Tane <runesong@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/usb/ov511.c does not compile
Message-ID: <20010615160518.A30332@sventech.com>
In-Reply-To: <3B2A67EF.EE0A6677@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B2A67EF.EE0A6677@earthlink.net>; from runesong@earthlink.net on Fri, Jun 15, 2001 at 02:54:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001, Kelledin Tane <runesong@earthlink.net> wrote:
> Apologies if this has been posted before.  I imagine it has.
> 
> In kernel 2.4.5 stock, ov511.c fails to compile.  A little intelligent
> searching through 2.4.4 source reveals that the following line in 2.4.4:
> 
> static const char version[] = "1.28";
> 
> is missing in 2.4.5, and this is why it does not compile.  While I could
> fix this myself manually (and plan to do so), it would be nice to get
> the developer's blessing on this, and also nice to know exactly what
> version number to give this driver in 2.4.5 stock.

This has already been fixed in the 2.4.5 pre patches.

JE

