Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNRet>; Thu, 14 Dec 2000 12:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLNRek>; Thu, 14 Dec 2000 12:34:40 -0500
Received: from feral.com ([192.67.166.1]:14882 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S129260AbQLNRe1>;
	Thu, 14 Dec 2000 12:34:27 -0500
Date: Thu, 14 Dec 2000 09:03:54 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: "Steven N. Hirsch" <shirsch@adelphia.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: <200012141507.eBEF7Ls48966@aslan.scsiguy.com>
Message-ID: <Pine.BSF.4.21.0012140901220.27706-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I don't know when the /proc stuff will return or what data will be
> provided there.

At the risk of tooting my own horn, you might put there that which I do for my
Qlogic driver- it lists current perio/offset values per target and a list of
currently running commands. It's very easy to support and very very useful.

The old linux aic driver also had a bunch of stats (binned to size)- I believe
I wrote that some years back- but that's not needed if you get Steve Tweedie's
sar package.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
