Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136007AbRDVKAi>; Sun, 22 Apr 2001 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136004AbRDVKA3>; Sun, 22 Apr 2001 06:00:29 -0400
Received: from duba06h06-0.dplanet.ch ([212.35.36.67]:40722 "EHLO
	duba06h06-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S136006AbRDVKAT>; Sun, 22 Apr 2001 06:00:19 -0400
Message-ID: <3AE2B84E.A14BC4E7@dplanet.ch>
Date: Sun, 22 Apr 2001 12:54:06 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
In-Reply-To: <E14r6kz-0004Zd-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Is there any kernel code that isn't GPLed?

No. Nearly all code is GPL or GPL compatible license.

> 
> There are numerous bits that are dual licensed, some which are licensed
> under the BSD non-advertising type license and some of it licensed under the
> X license.

I resign my proposal. Kernel sources are clean. I confused with the
(obsolete) libg++ which have file that start with GPL license,
at the bottom of file I find the BSD license and sometime in the
middle there is also some univesity license, thus libg++ users
should scann all file to see the copyright. Luckly the linux code is
more clean.


	giacomo
