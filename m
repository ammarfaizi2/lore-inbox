Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSLALB2>; Sun, 1 Dec 2002 06:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSLALB2>; Sun, 1 Dec 2002 06:01:28 -0500
Received: from aktion1.adns.de ([62.116.145.13]:15004 "EHLO aktion1.adns.de")
	by vger.kernel.org with ESMTP id <S261615AbSLALB1>;
	Sun, 1 Dec 2002 06:01:27 -0500
Message-ID: <3DE47AA9.7070101@asbest-online.de>
Date: Wed, 27 Nov 2002 08:56:25 +0100
From: Sven Krohlas <sven@asbest-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3a) Gecko/20021129
X-Accept-Language: de, de-at, de-de, de-li, de-lu,
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: ALI 15X3 IDE partition check lockup
References: <fa.ju6eafv.91saog@ifi.uio.no>
In-Reply-To: <fa.ju6eafv.91saog@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Debian's 2.2.20 kernel is OK and it's also possible to get a stock 2.4
> kernel working by NOT compiling in ALI 15X3 driver support (PIO mode is
> used instead).

I can also make it working by using ide=nodma on my system.

Marcelo, please include a fix for this in 2.4.21. Thanks :-)

