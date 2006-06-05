Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750791AbWFEWJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWFEWJ2 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFEWJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:09:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7628 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750791AbWFEWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:09:27 -0400
Subject: RE: ANNOUNCE: Linux UWB and Wireless USB project
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Inaky Perez-Gonzalez <inaky@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 23:24:36 +0100
Message-Id: <1149546276.1922.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-05 am 13:31 -0700, ysgrifennodd Perez-Gonzalez, Inaky:
> For what I know (and I could be wrong) max is around -40dBm/MHz 
> in the US. I am no expert in the nitty-gritty radio details, but 
> I've been told that is 3000 times less emissions than a common 
> cellphone, around .1 uW? [this is where my knowledge about radio
> *really* fades].

Life is never that simple. The total emissions of UWB are pretty low but
their spread across the wide frequency range makes them incredibly low
on any frequency - so very unlikely to interfere.

The total emissions across the set of frequencies as a sum (with
emphasis on some frequency ranges such as 2.4-2.5GHz) apparently matters
much more than the emissions at one frequency for things like human
exposure.

Alan

