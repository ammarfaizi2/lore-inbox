Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313000AbSC0M3v>; Wed, 27 Mar 2002 07:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313001AbSC0M3l>; Wed, 27 Mar 2002 07:29:41 -0500
Received: from zeus.kernel.org ([204.152.189.113]:6797 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313000AbSC0M3i>;
	Wed, 27 Mar 2002 07:29:38 -0500
Message-ID: <3CA1BABB.7030605@yahoo.com>
Date: Wed, 27 Mar 2002 15:27:39 +0300
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Anyone else seen VM related oops on 2.4.18?
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Mike Galbraith wrote:
> You can use dri with your 7500?
Yes. And it works really great until
either locks up the system or gets killed
by an Oops.

> Same processor as 8500 cards?
No idea.

> If so, which X sources are you using?
Mine works with 4.2.0's DRI, with latest
DRI from dri.sourceforge.net and with an
alternative drivers from gatos.sourceforge.net.
They all locks my system probably due to
an AMD Irongate.

> I bought an 8500 Evil Master II specifically because I saw Radeon
>    support in the kernel and X source.  Much to my chagrin, I can't
>    use dri because the source (4.2.0) says dri is not yet implimented
>    for that processor.
I was also confused by the fact that 7500
support doesn't exist in 4.1.0, but 4.2.0
really supports it.
Anyway, visit gatos.sourceforge.net and try
the drivers from there.
