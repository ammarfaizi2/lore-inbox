Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSG2JcZ>; Mon, 29 Jul 2002 05:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSG2JcZ>; Mon, 29 Jul 2002 05:32:25 -0400
Received: from ppp71-3-70.miem.edu.ru ([194.226.32.70]:21120 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S314138AbSG2JcY>;
	Mon, 29 Jul 2002 05:32:24 -0400
Message-ID: <3D450B0F.4090901@yahoo.com>
Date: Mon, 29 Jul 2002 13:29:51 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] New PC-Speaker driver
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

For all those people who still
don't have a sound card I want to
introduce a pc-speaker driver.
There were some other pc-speaker
drivers floating over the net, but
AFAIK no one is really finished and
usable.
My driver is originally based on
Michael Beck and David Woodhouse
driver, but it is havily reworked
and pretends to be 100% OSS compatible
producing nearly the best sound
one can ever get from pc-speaker.
Well, there is (currently) no
intention to get it into the mainstream
kernel so don't treat it too seriously.
However any comments or bugreports are
appreciated.

The latest patch for 2.4.18 kernel
is available here:
http://www.geocities.com/stssppnn/pcsp.html

